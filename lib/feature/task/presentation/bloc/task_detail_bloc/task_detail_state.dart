part of 'task_detail_bloc.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {}

final class GetCommentsLoading extends TaskDetailState {}

final class GetCommentsSuccess extends TaskDetailState {
  final List<CommentEntity> comment;

  const GetCommentsSuccess(this.comment);

  @override
  List<Object> get props => [comment];
}

final class GetCommentsFailure extends TaskDetailState {
  final String errorMessage;

  const GetCommentsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
