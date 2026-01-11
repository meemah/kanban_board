import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

abstract class TimerRepository {
  TaskTimerEntity? getTimer(String taskId);
  Future<void> startTimer(TaskEntity taskEntity);
  Future<void> clearTimer(String taskId);
  Future<void> stopTimer(TaskTimerEntity timer);
  Future<void> pauseTimer(TaskTimerEntity timer);
  Future<void> resumeTimer(TaskTimerEntity timer);
  List<TaskTimerEntity> getAllCompletedTimers();
}
