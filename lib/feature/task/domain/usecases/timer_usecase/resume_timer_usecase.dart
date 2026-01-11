import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class ResumeTimerUseCase {
  final TimerRepository timerRepo;

  ResumeTimerUseCase({required this.timerRepo});

  Future<Either<Failure, TaskTimerEntity>> call(TaskTimerEntity timer) async {
    try {
      await timerRepo.resumeTimer(timer);
      return Right(timerRepo.getTimer(timer.taskId)!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
