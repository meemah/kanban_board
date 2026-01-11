import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class GetTaskStatusUsecase {
  final TimerRepository _repository;

  const GetTaskStatusUsecase(this._repository);

  TaskStatus call(TaskEntity params) {
    TaskTimerEntity? timer = _repository.getTimer(params.id);
    if (params.isCompleted) {
      return TaskStatus.completed;
    }
    if (timer == null) {
      return TaskStatus.todo;
    } else {
      return TaskStatus.inProgress;
    }
  }
}
