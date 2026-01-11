import 'package:equatable/equatable.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';

class TaskTimerEntity extends Equatable {
  final int totalSeconds;
  final DateTime? startTime;
  final bool isRunning;
  final TaskEntity taskEntity;

  const TaskTimerEntity({
    required this.totalSeconds,
    this.startTime,
    required this.isRunning,
    required this.taskEntity,
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
    TaskEntity? taskEntity,
  }) {
    return TaskTimerEntity(
      taskEntity: taskEntity ?? this.taskEntity,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      startTime: startTime ?? this.startTime,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  TaskTimerEntity stop() {
    return copyWith(
      totalSeconds: currentElapsedSeconds,
      startTime: null,
      isRunning: false,
      taskEntity: taskEntity.copyWith(
        isCompleted: true,
        completedAt: DateTime.now(),
      ),
    );
  }

  TaskTimerEntity pause() {
    return copyWith(totalSeconds: currentElapsedSeconds, isRunning: false);
  }

  TaskTimerEntity resume() {
    return copyWith(startTime: DateTime.now(), isRunning: true);
  }

  @override
  List<Object?> get props => [taskEntity, totalSeconds, startTime, isRunning];
}
