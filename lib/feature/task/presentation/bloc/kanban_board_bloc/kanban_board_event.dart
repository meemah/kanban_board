part of 'kanban_board_bloc.dart';

sealed class KanbanBoardEvent extends Equatable {
  const KanbanBoardEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTaskEvent extends KanbanBoardEvent {}

final class MoveTaskEvent extends KanbanBoardEvent {}
