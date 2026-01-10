import 'package:dartz/dartz.dart' hide Task;
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart';

import '../../../../core/error/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, TaskEntity>> createTask({
    required UpsertTaskParams upsertTaskParams,
  });
  Future<Either<Failure, TaskEntity>> updateTask({
    required UpsertTaskParams upsertTaskParams,
  });

  Future<Either<Failure, bool>> completeTask(String id);
}
