import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String content;
  final String? description;
  final int priority;
  final String? projectId;
  final List<String> labels;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isCompleted;

  const TaskEntity({
    required this.id,
    required this.content,
    this.description,
    required this.priority,
    this.projectId,
    required this.labels,
    required this.createdAt,
    this.completedAt,
    this.isCompleted = false,
  });

  String get columnStatus {
    if (isCompleted) return 'Done';
    if (priority == 2) return 'In Progress';
    return 'To Do';
  }

  @override
  List<Object?> get props => [
    id,
    content,
    description,
    priority,
    projectId,
    labels,
    createdAt,
    completedAt,
    isCompleted,
  ];
}
