part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class GetCommentsLoading extends CommentState {}

final class GetCommentsSuccess extends CommentState {
  final List<CommentEntity> comments;

  const GetCommentsSuccess(this.comments);

  @override
  List<Object> get props => [comments];
}

final class GetCommentsFailure extends CommentState {
  final String errorMessage;

  const GetCommentsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class AddCommentFailure extends CommentState {
  final String errorMessage;

  const AddCommentFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

//
