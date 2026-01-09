import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task_detail/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<Comment>>> getComments(String taskId);
  Future<Either<Failure, Comment>> addComment(String taskId, String content);
}
