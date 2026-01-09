import 'package:dartz/dartz.dart' hide Task;

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

  Future<Either<Failure, void>> completeTask(String id);
  Future<Either<Failure, List<TaskEntity>>> getCompletedTasks();
}
