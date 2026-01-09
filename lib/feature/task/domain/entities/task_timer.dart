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

  String get formattedTime {
    final seconds = currentElapsedSeconds;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [taskId, totalSeconds, startTime, isRunning];
}
