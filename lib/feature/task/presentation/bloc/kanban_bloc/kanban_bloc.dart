import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart'
    show TaskEntity, TaskStatus;
import 'package:kanban_board/feature/task/domain/params/move_task_params.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_completed_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/move_task_usecase.dart';
import 'package:kanban_board/generated/l10n.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  final GetActiveTasksUsecase _getTasksUsecase;
  final GetTaskStatusUsecase _getTaskStatusUsecase;
  final MoveTaskUseCase _moveTaskUseCase;
  final GetCompletedTasksUsecase _completedTasksUsecase;
  KanbanBloc(
    this._getTasksUsecase,
    this._getTaskStatusUsecase,
    this._moveTaskUseCase,
    this._completedTasksUsecase,
  ) : super(KanbanInitial()) {
    on<GetAllTaskEvent>(_onGetTasks);
    on<MoveTaskEvent>(_moveTask);
    on<TaskAddedOrUpdatedEvent>(_onTaskUpsert);
  }

  Future<void> _onGetTasks(KanbanEvent event, Emitter<KanbanState> emit) async {
    try {
      emit(KanbanLoading());

      final result = await _getTasksUsecase.call(NoParams());

      result.fold((failure) => emit(KanbanFailure(failure.message)), (
        tasks,
      ) async {
        var result = _completedTasksUsecase.call();
        result.fold(
          (error) => emit(KanbanFailure(S.current.oppsErrorOccured)),
          (data) {
            List<TaskEntity> completedTasks = data.map((item) {
              return item.taskEntity;
            }).toList();
            final Map<TaskStatus, List<TaskEntity>> tasksByStatus = {
              TaskStatus.todo: [],
              TaskStatus.inProgress: [],
              TaskStatus.completed: completedTasks,
            };

            for (final task in tasks) {
              final status = _getTaskStatusUsecase.call(task);
              tasksByStatus[status]!.add(task);
            }

            emit(KanbanSuccess(tasksByStatus));
          },
        );
      });
    } catch (e) {
      emit(KanbanFailure(S.current.oppsErrorOccured));
    }
  }

  Future<void> _moveTask(MoveTaskEvent event, Emitter<KanbanState> emit) async {
    try {
      if (state is! KanbanSuccess) return;

      final currentState = state as KanbanSuccess;

      final tasksByStatus = {
        for (final entry in currentState.tasks.entries)
          entry.key: List<TaskEntity>.from(entry.value),
      };

      final updatedTask = event.task.copyWith(
        isCompleted: event.newStatus == TaskStatus.completed,
        completedAt: event.newStatus == TaskStatus.completed
            ? DateTime.now()
            : null,
      );

      tasksByStatus[event.oldStatus]!.removeWhere((t) => t.id == event.task.id);

      tasksByStatus[event.newStatus]!.insert(0, updatedTask);

      emit(KanbanSuccess(tasksByStatus));

      final result = await _moveTaskUseCase(
        MoveTaskParams(taskEntity: updatedTask, status: event.newStatus),
      );

      result.fold((_) {
        final rollbackState = {
          for (final entry in currentState.tasks.entries)
            entry.key: List<TaskEntity>.from(entry.value),
        };
        emit(KanbanSuccess(rollbackState));
      }, (_) {});
    } catch (e) {}
  }

  _onTaskUpsert(TaskAddedOrUpdatedEvent event, Emitter<KanbanState> emit) {
    final currentState = state;
    if (currentState is KanbanSuccess) {
      final tasksByStatus = {
        for (final entry in currentState.tasks.entries)
          entry.key: List<TaskEntity>.from(entry.value),
      };

      for (var status in tasksByStatus.keys) {
        tasksByStatus[status]?.removeWhere((t) => t.id == event.task.id);
      }

      final taskStatus = _getTaskStatusUsecase.call(event.task);

      tasksByStatus[taskStatus]?.insert(0, event.task);

      emit(KanbanSuccess(tasksByStatus));
    }
  }
}
