import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../domain/entities/task.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime? completedAt;
  @HiveField(5)
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.content,
    this.description,
    required this.createdAt,
    this.completedAt,
    this.isCompleted = false,
    t,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      content: json['content'] as String,
      description: json['description'] as String?,
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
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'is_completed': isCompleted,
    };
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      content: content,
      description: description,
      createdAt: createdAt,
      completedAt: completedAt,
      isCompleted: isCompleted,
    );
  }

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      id: task.id,
      content: task.content,
      description: task.description,
      createdAt: task.createdAt,
      completedAt: task.completedAt,
      isCompleted: task.isCompleted,
    );
  }

  TaskModel copyWith({
    String? id,
    String? content,
    String? description,
    DateTime? createdAt,
    DateTime? completedAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      content: content ?? this.content,
      description: description ?? this.description,
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
    createdAt,
    completedAt,
    isCompleted,
  ];
}
