import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/repositories/comment_repository.dart';

class AddComentUsecase implements UseCase<CommentEntity, AddCommentParams> {
  final CommentRepository _commentRepository;

  const AddComentUsecase(this._commentRepository);
  @override
  Future<Either<Failure, CommentEntity>> call(AddCommentParams params) async {
    return await _commentRepository.addComment(params);
  }
}

class AddCommentParams extends Equatable {
  final String taskId;
  final String content;

  const AddCommentParams({required this.taskId, required this.content});

  @override
  List<Object?> get props => [taskId, content];
}
