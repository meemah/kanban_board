import 'package:hive_flutter/hive_flutter.dart';
import 'package:kanban_board/core/local/database_key.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskTimerModelAdapter());
  await Hive.openBox<TaskTimerModel?>(DatabaseKey.taskTimerModel);
}
