part of 'kanban_bloc.dart';

sealed class KanbanEvent extends Equatable {
  const KanbanEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTaskEvent extends KanbanEvent {}

class MoveTaskEvent extends KanbanEvent {
  final TaskEntity task;
  final TaskStatus oldStatus;
  final TaskStatus newStatus;

  const MoveTaskEvent({
    required this.task,
    required this.oldStatus,
    required this.newStatus,
  });

  @override
  List<Object> get props => [task, oldStatus, newStatus];
}
