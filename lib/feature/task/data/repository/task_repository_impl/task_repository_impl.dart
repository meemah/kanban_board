import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/data/datasource/task_remote_datasource.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/upsert_task_usecase.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, bool>> completeTask(String id) async {
    try {
      await remoteDataSource.completeTask(id);
      return Right(true);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> createTask({
    required UpsertTaskParams upsertTaskParams,
  }) async {
    try {
      final taskModel = await remoteDataSource.createTask(
        upsertTaskParams: upsertTaskParams,
      );
      return Right(taskModel.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final taskModels = await remoteDataSource.getTasks();
      return Right(taskModels.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask({
    required UpsertTaskParams upsertTaskParams,
  }) async {
    try {
      final taskModel = await remoteDataSource.updateTask(
        upsertTaskParams: upsertTaskParams,
      );
      return Right(taskModel.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
