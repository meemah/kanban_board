import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task_detail/data/datasource/comment_remote_datasource.dart';
import 'package:kanban_board/feature/task_detail/domain/entities/comment.dart';
import 'package:kanban_board/feature/task_detail/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Comment>>> getComments(String taskId) async {
    try {
      final commentModels = await remoteDataSource.getComments(taskId);
      return Right(commentModels.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> addComment(
    String taskId,
    String content,
  ) async {
    try {
      final commentModel = await remoteDataSource.addComment(taskId, content);
      return Right(commentModel.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
