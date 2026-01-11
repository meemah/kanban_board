part of 'kanban_bloc.dart';

sealed class KanbanState extends Equatable {
  const KanbanState();

  @override
  List<Object> get props => [];
}

final class KanbanInitial extends KanbanState {}

class KanbanLoading extends KanbanState {}

final class KanbanSuccess extends KanbanState {
  final Map<TaskStatus, List<TaskEntity>> tasks;
  const KanbanSuccess(this.tasks);

  List<TaskEntity> getTasksByStatus(TaskStatus status) {
    return tasks[status] ?? [];
  }

  @override
  List<Object> get props => [tasks];
}

final class KanbanFailure extends KanbanState {
  final String errorMessage;

  const KanbanFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
