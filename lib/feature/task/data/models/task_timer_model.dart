import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/task_timer.dart';

part 'task_timer_model.g.dart';

@HiveType(typeId: 1)
class TaskTimerModel extends Equatable {
  @HiveField(0)
  final String taskId;
  @HiveField(1)
  final int totalSeconds;
  @HiveField(2)
  final DateTime? startTime;
  @HiveField(3)
  final bool isRunning;

  const TaskTimerModel({
    required this.taskId,
    required this.totalSeconds,
    this.startTime,
    required this.isRunning,
  });

  factory TaskTimerModel.fromJson(Map<String, dynamic> json) {
    return TaskTimerModel(
      taskId: json['task_id'] as String,
      totalSeconds: json['total_seconds'] as int,
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'] as String)
          : null,
      isRunning: json['is_running'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'total_seconds': totalSeconds,
      'start_time': startTime?.toIso8601String(),
      'is_running': isRunning,
    };
  }

  TaskTimer toEntity() {
    return TaskTimer(
      taskId: taskId,
      totalSeconds: totalSeconds,
      startTime: startTime,
      isRunning: isRunning,
    );
  }

  factory TaskTimerModel.fromEntity(TaskTimer timer) {
    return TaskTimerModel(
      taskId: timer.taskId,
      totalSeconds: timer.totalSeconds,
      startTime: timer.startTime,
      isRunning: timer.isRunning,
    );
  }

  TaskTimerModel copyWith({
    String? taskId,
    int? totalSeconds,
    DateTime? startTime,
    bool? isRunning,
  }) {
    return TaskTimerModel(
      taskId: taskId ?? this.taskId,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      startTime: startTime ?? this.startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  @override
  List<Object?> get props => [taskId, totalSeconds, startTime, isRunning];
}
