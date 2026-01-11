import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class GetCompletedTasksUsecase {
  final TimerRepository _repository;

  const GetCompletedTasksUsecase(this._repository);

  List<TaskTimerEntity> call() {
    return _repository.getAllCompletedTimers();
  }
}
