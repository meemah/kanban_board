import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';

abstract class CommentRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(
    GetCommentsParams getCommentParams,
  );
  Future<Either<Failure, CommentEntity>> addComment(
    AddCommentParams addCommentParams,
  );
}
