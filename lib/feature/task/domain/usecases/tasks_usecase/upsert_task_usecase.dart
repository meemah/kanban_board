import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';

class UpsertTaskUseCase implements UseCase<TaskEntity, UpsertTaskParams> {
  final TaskRepository _repository;

  const UpsertTaskUseCase(this._repository);

  @override
  Future<Either<Failure, TaskEntity>> call(UpsertTaskParams params) async {
    if (params.id == null) {
      return await _repository.createTask(upsertTaskParams: params);
    } else {
      return await _repository.updateTask(upsertTaskParams: params);
    }
  }
}
