import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class GetTaskTimerUsecase {
  final TimerRepository timerRepo;

  GetTaskTimerUsecase({required this.timerRepo});

  Either<Failure, TaskTimerEntity?> call(TaskEntity task) {
    try {
      final timer = timerRepo.getTimer(task.id);
      return Right(timer);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
