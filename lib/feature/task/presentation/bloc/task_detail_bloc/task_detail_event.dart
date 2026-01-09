part of 'task_detail_bloc.dart';

sealed class TaskDetailEvent extends Equatable {
  const TaskDetailEvent();

  @override
  List<Object> get props => [];
}

final class GetCommentsEvent extends TaskDetailEvent {
  final GetCommentsParams params;

  const GetCommentsEvent({required this.params});

  @override
  List<Object> get props => [params];
}

final class AddCommentEvent extends TaskDetailEvent {
  final AddCommentParams params;

  const AddCommentEvent({required this.params});

  @override
  List<Object> get props => [params];
}
