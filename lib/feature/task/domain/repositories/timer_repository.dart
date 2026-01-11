import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

abstract class TimerRepository {
  TaskTimerEntity? getTimer(String taskId);
  Future<Either<Failure, void>> startTimer(TaskEntity taskEntity);

  Future<Either<Failure, void>> stopTimer(TaskTimerEntity timer);

  Future<Either<Failure, void>> pauseTimer(TaskTimerEntity timer);

  Future<Either<Failure, void>> resumeTimer(TaskTimerEntity timer);

  Future<Either<Failure, void>> clearTimer(String taskId);

  Either<Failure, List<TaskTimerEntity>> getAllCompletedTimers();
}
