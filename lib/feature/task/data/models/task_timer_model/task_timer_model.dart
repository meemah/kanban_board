import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kanban_board/feature/task/data/models/task_model/task_model.dart';

import '../../../domain/entities/task_timer.dart';

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

  @HiveField(4)
  final TaskModel taskModel;

  const TaskTimerModel({
    required this.taskId,
    required this.totalSeconds,
    this.startTime,
    required this.isRunning,
    required this.taskModel,
  });

  TaskTimerEntity toEntity() {
    return TaskTimerEntity(
      taskEntity: taskModel.toEntity(),
      taskId: taskId,
      totalSeconds: totalSeconds,
      startTime: startTime,
      isRunning: isRunning,
    );
  }

  factory TaskTimerModel.fromEntity(TaskTimerEntity timer) {
    return TaskTimerModel(
      taskModel: TaskModel(
        description: timer.taskEntity.description,
        isCompleted: timer.taskEntity.isCompleted,
        completedAt: timer.taskEntity.completedAt,
        id: timer.taskId,
        content: timer.taskEntity.content,
        createdAt: timer.taskEntity.createdAt,
      ),

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
    TaskModel? taskModel,
  }) {
    return TaskTimerModel(
      taskModel: taskModel ?? this.taskModel,
      taskId: taskId ?? this.taskId,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      startTime: startTime ?? this.startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  @override
  List<Object?> get props => [taskId, totalSeconds, startTime, isRunning];
}
