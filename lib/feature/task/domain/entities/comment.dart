import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String taskId;
  final String content;
  final DateTime postedAt;
  final bool isPending;

  const CommentEntity({
    required this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
    this.isPending = false,
  });

  @override
  List<Object> get props => [id, taskId, content, postedAt, isPending];
}
