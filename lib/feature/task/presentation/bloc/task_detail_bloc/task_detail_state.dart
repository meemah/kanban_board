part of 'task_detail_bloc.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {}

final class TaskDetailLoaded extends TaskDetailState {
  final TaskEntity task;
  final TaskStatus status;
  final TaskTimerEntity? timer;

  const TaskDetailLoaded({
    required this.task,
    required this.status,
    this.timer,
  });

  TaskDetailLoaded copyWith({
    TaskEntity? task,
    TaskStatus? status,
    TaskTimerEntity? timer,
  }) {
    return TaskDetailLoaded(
      task: task ?? this.task,
      status: status ?? this.status,
      timer: timer ?? this.timer,
    );
  }

  @override
  List<Object?> get props => [
    task.id,
    status,
    timer?.isRunning,
    timer?.totalSeconds,
    timer?.startTime,
  ];
}

final class TaskDetailFailure extends TaskDetailState {
  final String errorMessage;

  const TaskDetailFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
