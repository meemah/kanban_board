import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class GetTaskStatusUsecase {
  final TimerRepository _repository;

  const GetTaskStatusUsecase(this._repository);

  Future<TaskStatus> call(TaskEntity params) async {
    TaskTimerEntity? timer = await _repository.getTimer(params.id);
    if (timer == null) {
      return TaskStatus.todo;
    } else {
      if (params.isCompleted) {
        return TaskStatus.completed;
      }
      return TaskStatus.inprogess;
    }
  }
}
