import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';

class UpsertTaskParams extends Equatable {
  final String? id;
  final String content;
  final String? description;
  final int priority;

  final DateTime? dueDate;

  const UpsertTaskParams({
    this.id,
    required this.content,
    this.description,
    this.priority = 1,
    this.dueDate,
  });

  @override
  List<Object?> get props => [id, content, description, priority];
}

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
