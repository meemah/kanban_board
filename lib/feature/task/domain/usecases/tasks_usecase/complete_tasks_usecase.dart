import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';

class CompleteTasksUsecase implements UseCase<bool, String> {
  final TaskRepository _repository;

  const CompleteTasksUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    return await _repository.completeTask(id);
  }
}
