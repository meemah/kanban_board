part of 'kanban_board_bloc.dart';

sealed class KanbanBoardState extends Equatable {
  const KanbanBoardState();

  @override
  List<Object> get props => [];
}

final class KanbanBoardInitial extends KanbanBoardState {}

final class KanbanBoardLoading extends KanbanBoardState {}

final class KanbanBoardSuccess extends KanbanBoardState {
  final List<TaskEntity> tasks;

  const KanbanBoardSuccess(this.tasks);

  @override
  List<Object> get props => [tasks];
}

final class KanbanBoardFailure extends KanbanBoardState {
  final String errorMessage;

  const KanbanBoardFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
