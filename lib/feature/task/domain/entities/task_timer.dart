import 'package:equatable/equatable.dart';

class TaskTimerEntity extends Equatable {
  final String taskId;
  final int totalSeconds;
  final DateTime? startTime;
  final bool isRunning;

  const TaskTimerEntity({
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

  TaskTimerEntity copyWith({
    int? totalSeconds,
    DateTime? startTime,
    bool? isRunning,
  }) {
    return TaskTimerEntity(
      taskId: taskId,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      startTime: startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  TaskTimerEntity stop() {
    return copyWith(
      totalSeconds: currentElapsedSeconds,
      startTime: null,
      isRunning: false,
    );
  }

  TaskTimerEntity pause() {
    return copyWith(totalSeconds: currentElapsedSeconds, isRunning: false);
  }

  TaskTimerEntity resume() {
    return copyWith(startTime: DateTime.now(), isRunning: true);
  }

  @override
  List<Object?> get props => [taskId, totalSeconds, startTime, isRunning];
}
