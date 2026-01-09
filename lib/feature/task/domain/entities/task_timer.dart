import 'package:equatable/equatable.dart';

class TaskTimer extends Equatable {
  final String taskId;
  final int totalSeconds;
  final DateTime? startTime;
  final bool isRunning;

  const TaskTimer({
    required this.taskId,
    required this.totalSeconds,
    this.startTime,
    required this.isRunning,
  });

  int get currentElapsedSeconds {
    if (!isRunning || startTime == null) return totalSeconds;
    final elapsed = DateTime.now().difference(startTime!).inSeconds;
    return totalSeconds + elapsed;
  }

  TaskTimer copyWith({
    int? totalSeconds,
    DateTime? startTime,
    bool? isRunning,
  }) {
    return TaskTimer(
      taskId: taskId,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      startTime: startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  TaskTimer stop() {
    return copyWith(
      totalSeconds: currentElapsedSeconds,
      startTime: null,
      isRunning: false,
    );
  }

  TaskTimer pause() {
    return copyWith(totalSeconds: currentElapsedSeconds, isRunning: false);
  }

  TaskTimer resume() {
    return copyWith(startTime: DateTime.now(), isRunning: true);
  }

  @override
  List<Object?> get props => [taskId, totalSeconds, startTime, isRunning];
}
