import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';

class GetActiveTasksUsecase implements UseCase<List<TaskEntity>, NoParams> {
  final TaskRepository _repository;

  const GetActiveTasksUsecase(this._repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await _repository.getTasks();
  }
}
