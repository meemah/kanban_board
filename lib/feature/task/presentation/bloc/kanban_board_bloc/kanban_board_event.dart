part of 'kanban_board_bloc.dart';

sealed class KanbanBoardEvent extends Equatable {
  const KanbanBoardEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTaskEvent extends KanbanBoardEvent {}

class MoveTaskEvent extends KanbanBoardEvent {
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
