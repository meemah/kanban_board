part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

final class GetCommentsEvent extends CommentEvent {
  final String taskId;

  const GetCommentsEvent({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

final class AddCommentEvent extends CommentEvent {
  final AddCommentParams addCommentParams;

  const AddCommentEvent({required this.addCommentParams});

  @override
  List<Object> get props => [addCommentParams];
}
