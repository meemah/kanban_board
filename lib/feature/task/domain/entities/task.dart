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

enum TaskStatus {
  todo("To Do"),
  inprogess("In Progress"),
  completed("Completed");

  final String title;
  const TaskStatus(this.title);
}
