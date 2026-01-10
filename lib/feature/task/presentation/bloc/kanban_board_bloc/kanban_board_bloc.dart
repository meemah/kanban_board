import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart'
    show TaskEntity, TaskStatus;
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/move_task_usecase.dart';
import 'package:kanban_board/generated/l10n.dart';

part 'kanban_board_event.dart';
part 'kanban_board_state.dart';

class KanbanBoardBloc extends Bloc<KanbanBoardEvent, KanbanBoardState> {
  final GetTasksUsecase _getTasksUsecase;
  final GetTaskStatusUsecase _getTaskStatusUsecase;
  final MoveTaskUseCase _moveTaskUseCase;
  KanbanBoardBloc(
    this._getTasksUsecase,
    this._getTaskStatusUsecase,
    this._moveTaskUseCase,
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
        final Map<TaskStatus, List<TaskEntity>> tasksByStatus = {
          TaskStatus.todo: [],
          TaskStatus.inprogess: [],
          TaskStatus.completed: [],
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
    if (state is! KanbanBoardSuccess) return;

    final currentState = state as KanbanBoardSuccess;

    // 1. Optimistic update
    final tasksByStatus = Map<TaskStatus, List<TaskEntity>>.from(
      currentState.tasks,
    );

    // Remove from old status
    tasksByStatus[event.oldStatus]?.removeWhere((t) => t.id == event.task.id);

    // Add to new status

    tasksByStatus[event.newStatus]?.insert(0, event.task);

    emit(KanbanBoardSuccess(tasksByStatus));

    // 2. Call backend
    final result = await _moveTaskUseCase.call(
      MoveTaskParams(taskEntity: event.task, status: event.newStatus),
    );

    // 3. Rollback if failed
    result.fold(
      (failure) {
        // Undo the move
        tasksByStatus[event.newStatus]?.removeWhere(
          (t) => t.id == event.task.id,
        );
        tasksByStatus[event.oldStatus]?.insert(0, event.task);
        emit(KanbanBoardSuccess(tasksByStatus));

        // Show error
        // AppSnackBar.show(
        //   context,
        //   message: failure.message,
        //   appSnackbarType: AppSnackbarType.failed,
        // );
      },
      (_) {
        // Success — nothing else needed, UI already updated
      },
    );
  }
}
