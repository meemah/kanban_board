import 'package:dartz/dartz.dart' hide Task;
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> createTask({
    required String content,
    String? description,
    int priority = 1,
    List<String>? labels,
  });
  Future<Either<Failure, TaskEntity>> updateTask(
    String id, {
    String? content,
    String? description,
    int? priority,
    List<String>? labels,
  });
  Future<Either<Failure, void>> deleteTask(String id);
  Future<Either<Failure, void>> completeTask(String id);
  Future<Either<Failure, TaskTimer>> getTimer(String taskId);
  Future<Either<Failure, TaskTimer>> startTimer(String taskId);
  Future<Either<Failure, TaskTimer>> stopTimer(String taskId);
  Future<Either<Failure, List<TaskEntity>>> getCompletedTasks();
}
