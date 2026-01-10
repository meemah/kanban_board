import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart'
    show TaskEntity;
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
    emit(KanbanBoardLoading());

    final result = await _getTasksUsecase.call(NoParams());

    result.fold(
      (failure) => emit(KanbanBoardFailure(failure.message)),
      (task) => emit(KanbanBoardSuccess(task)),
    );
  }

  // Map<TaskStatus, List<TaskEntity>> _groupTasks(List<TaskEntity> tasks) {
  //   return {
  //     TaskStatus.todo: tasks
  //         .where((t) => t.taskStatus == TaskStatus.todo)
  //         .toList(),
  //     TaskStatus.inprogess: tasks
  //         .where((t) => t.taskStatus == TaskStatus.inprogess)
  //         .toList(),
  //     TaskStatus.completed: tasks.where((t) => t.isCompleted).toList(),
  //   };
  // }
}
