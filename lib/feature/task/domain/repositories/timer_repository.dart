import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

abstract class TimerRepository {
  Future<TaskTimer?> getTimer(String taskId);
  Future<void> startTimer(String taskId);
  Future<void> clearTimer(String taskId);
  Future<void> stopTimer(TaskTimer timer);
  Future<void> pauseTimer(TaskTimer timer);
  Future<void> resumeTimer(TaskTimer timer);
}
