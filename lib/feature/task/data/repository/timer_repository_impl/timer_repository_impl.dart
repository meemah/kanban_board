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
    final model = localDataSource.getTimer(taskId);
    return model?.toEntity();
  }

  @override
  Future<void> startTimer(TaskEntity taskEntity) async {
    final timer = TaskTimerEntity(
      taskEntity: taskEntity,
      taskId: taskEntity.id,
      totalSeconds: 0,
      startTime: DateTime.now(),
      isRunning: true,
    );
    await _saveTimer(timer);
  }

  @override
  Future<void> stopTimer(TaskTimerEntity timer) async {
    await _saveTimer(timer.stop());
  }

  @override
  Future<void> pauseTimer(TaskTimerEntity timer) async {
    await _saveTimer(timer.pause());
  }

  @override
  Future<void> resumeTimer(TaskTimerEntity timer) async {
    await _saveTimer(timer.resume());
  }

  @override
  Future<void> clearTimer(String taskId) async {
    await localDataSource.deleteTimer(taskId);
  }

  Future<void> _saveTimer(TaskTimerEntity timer) async {
    await localDataSource.saveTimer(TaskTimerModel.fromEntity(timer));
  }

  @override
  List<TaskTimerEntity> getAllCompletedTimers() {
    return localDataSource
        .getAllTimers()
        .where((t) => t != null && t.taskModel.isCompleted)
        .map((t) => t!.toEntity())
        .toList();
  }
}
