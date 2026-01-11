import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class PauseTimerUseCase {
  final TimerRepository repo;

  PauseTimerUseCase(this.repo);

  Future<Either<Failure, TaskTimerEntity>> call(TaskTimerEntity timer) async {
    try {
      await repo.pauseTimer(timer);
      return Right(repo.getTimer(timer.taskId)!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
