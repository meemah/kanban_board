import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/repositories/comment_repository.dart';

class GetCommentsUsecase extends UseCase<List<CommentEntity>, String> {
  final CommentRepository _commentRepository;

  GetCommentsUsecase({required CommentRepository commentRepository})
    : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, List<CommentEntity>>> call(String taskId) async {
    return await _commentRepository.getComments(taskId);
  }
}
