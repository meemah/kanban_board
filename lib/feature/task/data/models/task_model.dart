import 'package:equatable/equatable.dart';

import '../../domain/entities/task.dart';

class TaskModel extends Equatable {
  final String id;
  final String content;
  final String? description;
  final int priority;
  final String? projectId;
  final List<String> labels;
  final DateTime createdAt;
  final DateTime? completedAt;
  final bool isCompleted;

  const TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      content: json['content'] as String,
      description: json['description'] as String?,
      priority: json['priority'] as int,
      projectId: json['project_id'] as String?,
      labels: (json['labels'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'description': description,
      'priority': priority,
      'project_id': projectId,
      'labels': labels,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  Task toEntity() {
    return Task(
      id: id,
      content: content,
      description: description,
      priority: priority,
      projectId: projectId,
      labels: labels,
      createdAt: createdAt,
      completedAt: completedAt,
      isCompleted: isCompleted,
    );
  }

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      content: task.content,
      description: task.description,
      priority: task.priority,
      projectId: task.projectId,
      labels: task.labels,
      createdAt: task.createdAt,
      completedAt: task.completedAt,
      isCompleted: task.isCompleted,
    );
  }

  TaskModel copyWith({
    String? id,
    String? content,
    String? description,
    int? priority,
    String? projectId,
    List<String>? labels,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      projectId: projectId ?? this.projectId,
      labels: labels ?? this.labels,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
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
