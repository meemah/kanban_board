part of 'task_detail_bloc.dart';

sealed class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetCommentsEvent extends TaskDetailEvent {
  final String taskId;

  const GetCommentsEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

final class AddCommentEvent extends TaskDetailEvent {
  final AddCommentParams addCommentParams;

  const AddCommentEvent({required this.addCommentParams});

  @override
  List<Object> get props => [addCommentParams];
}
