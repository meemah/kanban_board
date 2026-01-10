import 'package:hive/hive.dart';
import 'package:kanban_board/core/local/box_provider.dart';
import 'package:kanban_board/core/util/di/injection_container.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';

abstract class TimerLocalDatasource {
  TaskTimerModel? getTimer(String taskId);
  Future<void> saveTimer(TaskTimerModel timer);
  Future<void> deleteTimer(String taskId);
}

class TimerLocalDatasourceImpl implements TimerLocalDatasource {
  final BoxProvider<TaskTimerModel> boxProvider;

  TimerLocalDatasourceImpl(this.boxProvider);

  @override
  TaskTimerModel? getTimer(String taskId) {
    Box<TaskTimerModel?> box = Hive.box(taskDB);
    return box.get(taskId);
  }

  @override
  Future<void> saveTimer(TaskTimerModel timer) async {
    final box = await boxProvider.openBox(taskDB);
    await box.put(timer.taskId, timer);
  }

  @override
  Future<void> deleteTimer(String taskId) async {
    final box = await boxProvider.openBox(taskDB);
    await box.delete(taskId);
  }
}
