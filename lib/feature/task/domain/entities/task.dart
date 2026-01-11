import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kanban_board/core/theme/app_colors.dart';

class TaskEntity extends Equatable {
  final String id;
  final String content;
  final String? description;
  final DateTime createdAt;
  final bool isCompleted;
  final DateTime? completedAt;

  const TaskEntity({
    required this.id,
    required this.content,
    this.description,
    required this.createdAt,
    this.isCompleted = false,
    this.completedAt,
  });

  TaskEntity copyWith({
    String? content,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return TaskEntity(
      id: id,
      content: content ?? this.content,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    content,
    description,
    createdAt,
    isCompleted,
    completedAt,
  ];
}

enum TaskStatus {
  todo("To Do", AppColors.textGray),
  inProgress("In Progress", AppColors.amber),
  completed("Completed", AppColors.green);

  final String title;
  final Color color;

  const TaskStatus(this.title, this.color);
}
