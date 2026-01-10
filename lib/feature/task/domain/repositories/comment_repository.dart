import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(String taskId);
  Future<Either<Failure, CommentEntity>> addComment(
    AddCommentParams addCommentParams,
  );
}
