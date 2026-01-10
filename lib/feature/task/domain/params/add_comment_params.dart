import 'package:equatable/equatable.dart';

class AddCommentParams extends Equatable {
  final String taskId;
  final String content;

  const AddCommentParams({required this.taskId, required this.content});

  @override
  List<Object?> get props => [taskId, content];
}
