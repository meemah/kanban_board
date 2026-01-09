import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String taskId;
  final String content;
  final DateTime postedAt;

  const CommentEntity({
    required this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
  });

  @override
  List<Object> get props => [id, taskId, content, postedAt];
}
