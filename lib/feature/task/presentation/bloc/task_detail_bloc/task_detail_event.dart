part of 'task_detail_bloc.dart';

sealed class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object> get props => [];
}

final class InitializeTaskDetailEvent extends TaskDetailEvent {
  final TaskEntity task;

  const InitializeTaskDetailEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class PauseTaskTimerEvent extends TaskDetailEvent {}

class ResumeTaskTimerEvent extends TaskDetailEvent {}
