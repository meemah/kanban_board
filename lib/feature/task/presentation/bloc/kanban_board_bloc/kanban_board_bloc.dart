import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart'
    show TaskEntity, TaskStatus;
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/params/move_task_params.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_completed_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/move_task_usecase.dart';
import 'package:kanban_board/generated/l10n.dart';

part 'kanban_board_event.dart';
part 'kanban_board_state.dart';

class KanbanBoardBloc extends Bloc<KanbanBoardEvent, KanbanBoardState> {
  final GetActiveTasksUsecase _getTasksUsecase;
  final GetTaskStatusUsecase _getTaskStatusUsecase;
  final MoveTaskUseCase _moveTaskUseCase;
  final GetCompletedTasksUsecase _completedTasksUsecase;
  KanbanBoardBloc(
    this._getTasksUsecase,
    this._getTaskStatusUsecase,
    this._moveTaskUseCase,
    this._completedTasksUsecase,
  ) : super(KanbanBoardInitial()) {
    on<GetAllTaskEvent>(_onGetTasks);
    on<MoveTaskEvent>(_moveTask);
  }

  Future<void> _onGetTasks(
    KanbanBoardEvent event,
    Emitter<KanbanBoardState> emit,
  ) async {
    try {
      emit(KanbanBoardLoading());

      final result = await _getTasksUsecase.call(NoParams());

      result.fold((failure) => emit(KanbanBoardFailure(failure.message)), (
        tasks,
      ) async {
        List<TaskTimerEntity> completedTasksModel = _completedTasksUsecase
            .call();
        List<TaskEntity> completedTasks = completedTasksModel.map((item) {
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

        emit(KanbanBoardSuccess(tasksByStatus));
      });
    } catch (e) {
      emit(KanbanBoardFailure(S.current.oppsErrorOccured));
    }
  }

  Future<void> _moveTask(
    MoveTaskEvent event,
    Emitter<KanbanBoardState> emit,
  ) async {
    try {
      if (state is! KanbanBoardSuccess) return;

      final currentState = state as KanbanBoardSuccess;

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

      emit(KanbanBoardSuccess(tasksByStatus));

      final result = await _moveTaskUseCase(
        MoveTaskParams(taskEntity: updatedTask, status: event.newStatus),
      );

      result.fold((_) {
        final rollbackState = {
          for (final entry in currentState.tasks.entries)
            entry.key: List<TaskEntity>.from(entry.value),
        };
        emit(KanbanBoardSuccess(rollbackState));
      }, (_) {});
    } catch (e) {}
  }
}
