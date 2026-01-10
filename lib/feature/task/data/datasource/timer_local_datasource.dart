import 'package:kanban_board/core/local/box_provider.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';

abstract class TimerLocalDatasource {
  Future<TaskTimerModel?> getTimer(String taskId);
  Future<void> saveTimer(TaskTimerModel timer);
  Future<void> deleteTimer(String taskId);
}

class TimerLocalDatasourceImpl implements TimerLocalDatasource {
  static const _boxName = 'timers';

  final BoxProvider<TaskTimerModel> boxProvider;

  TimerLocalDatasourceImpl(this.boxProvider);

  @override
  Future<TaskTimerModel?> getTimer(String taskId) async {
    final box = await boxProvider.openBox(_boxName);
    return box.get(taskId);
  }

  @override
  Future<void> saveTimer(TaskTimerModel timer) async {
    final box = await boxProvider.openBox(_boxName);
    await box.put(timer.taskId, timer);
  }

  @override
  Future<void> deleteTimer(String taskId) async {
    final box = await boxProvider.openBox(_boxName);
    await box.delete(taskId);
  }
}
