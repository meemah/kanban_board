import 'package:hive/hive.dart';
import 'package:kanban_board/core/local/database_key.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';

abstract class TimerLocalDatasource {
  TaskTimerModel? getTimer(String taskId);
  Future<void> saveTimer(TaskTimerModel timer);
  Future<void> deleteTimer(String taskId);
  List<TaskTimerModel?> getAllTimers();
}

class TimerLocalDatasourceImpl implements TimerLocalDatasource {
  @override
  TaskTimerModel? getTimer(String taskId) {
    try {
      final box = Hive.box<TaskTimerModel?>(DatabaseKey.taskTimerModel);
      return box.get(taskId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveTimer(TaskTimerModel timer) async {
    try {
      final box = Hive.box<TaskTimerModel?>(DatabaseKey.taskTimerModel);
      await box.put(timer.taskModel.id, timer);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTimer(String taskId) async {
    try {
      final box = Hive.box<TaskTimerModel?>(DatabaseKey.taskTimerModel);
      await box.delete(taskId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<TaskTimerModel?> getAllTimers() {
    try {
      final box = Hive.box<TaskTimerModel?>(DatabaseKey.taskTimerModel);
      return box.values.toList();
    } catch (e) {
      return [];
    }
  }
}
