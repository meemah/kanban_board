import 'package:equatable/equatable.dart';

import '../../domain/entities/comment.dart';

class CommentModel extends Equatable {
  final String id;
  final String taskId;
  final String content;
  final DateTime postedAt;

  const CommentModel({
    required this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      content: json['content'] as String,
      postedAt: DateTime.parse(json['posted_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'content': content,
      'posted_at': postedAt.toIso8601String(),
    };
  }

  Comment toEntity() {
    return Comment(
      id: id,
      taskId: taskId,
      content: content,
      postedAt: postedAt,
    );
  }

  @override
  List<Object> get props => [id, taskId, content, postedAt];
}
