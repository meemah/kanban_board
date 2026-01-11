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
    Box<TaskTimerModel?> box = Hive.box(DatabaseKey.taskTimerModel);
    return box.get(taskId);
  }

  @override
  Future<void> saveTimer(TaskTimerModel timer) async {
    Box<TaskTimerModel?> box = Hive.box(DatabaseKey.taskTimerModel);
    await box.put(timer.taskId, timer);
  }

  @override
  Future<void> deleteTimer(String taskId) async {
    Box<TaskTimerModel?> box = Hive.box(DatabaseKey.taskTimerModel);
    await box.delete(taskId);
  }

  @override
  List<TaskTimerModel?> getAllTimers() {
    Box<TaskTimerModel?> box = Hive.box(DatabaseKey.taskTimerModel);
    return box.values.toList();
  }
}
