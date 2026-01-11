import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/data/datasource/timer_local_datasource.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

class TimerRepositoryImpl implements TimerRepository {
  final TimerLocalDatasource localDataSource;

  TimerRepositoryImpl(this.localDataSource);

  @override
  TaskTimerEntity? getTimer(String taskId) {
    try {
      final model = localDataSource.getTimer(taskId);
      return model?.toEntity();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Failure, void>> startTimer(TaskEntity taskEntity) async {
    try {
      final timer = TaskTimerEntity(
        taskEntity: taskEntity,
        totalSeconds: 0,
        startTime: DateTime.now(),
        isRunning: true,
      );
      await _saveTimer(timer);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> stopTimer(TaskTimerEntity timer) async {
    try {
      await _saveTimer(timer.stop());
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> pauseTimer(TaskTimerEntity timer) async {
    try {
      await _saveTimer(timer.pause());
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resumeTimer(TaskTimerEntity timer) async {
    try {
      await _saveTimer(timer.resume());
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearTimer(String taskId) async {
    try {
      await localDataSource.deleteTimer(taskId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Either<Failure, List<TaskTimerEntity>> getAllCompletedTimers() {
    try {
      final timers = localDataSource
          .getAllTimers()
          .where((t) => t != null && t.taskModel.isCompleted)
          .map((t) => t!.toEntity())
          .toList();
      return Right(timers);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  Future<void> _saveTimer(TaskTimerEntity timer) async {
    await localDataSource.saveTimer(TaskTimerModel.fromEntity(timer));
  }
}
