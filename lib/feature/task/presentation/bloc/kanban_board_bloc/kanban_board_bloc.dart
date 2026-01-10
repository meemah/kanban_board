import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart'
    show TaskEntity, TaskStatus;
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';

part 'kanban_board_event.dart';
part 'kanban_board_state.dart';

class KanbanBoardBloc extends Bloc<KanbanBoardEvent, KanbanBoardState> {
  final GetTasksUsecase _getTasksUsecase;
  final GetTaskStatusUsecase _getTaskStatusUsecase;
  KanbanBoardBloc(this._getTasksUsecase, this._getTaskStatusUsecase)
    : super(KanbanBoardInitial()) {
    on<GetAllTaskEvent>(_onGetTasks);
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
      emit(KanbanBoardFailure("Opps, error occured"));
    }
  }
}
