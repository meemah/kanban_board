import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class GetCompletedTasksUsecase {
  final TimerRepository _repository;

  const GetCompletedTasksUsecase(this._repository);

  Either<Failure, List<TaskTimerEntity>> call() {
    return _repository.getAllCompletedTimers();
  }
}
