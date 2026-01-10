import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

abstract class TimerRepository {
  TaskTimerEntity? getTimer(String taskId);
  Future<void> startTimer(String taskId);
  Future<void> clearTimer(String taskId);
  Future<void> stopTimer(TaskTimerEntity timer);
  Future<void> pauseTimer(TaskTimerEntity timer);
  Future<void> resumeTimer(TaskTimerEntity timer);
}
