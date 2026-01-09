import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/repositories/comment_repository.dart';

class GetCommentsUsecase extends UseCase<List<Comment>, GetCommentsParams> {
  final CommentRepository _commentRepository;

  GetCommentsUsecase({required CommentRepository commentRepository})
    : _commentRepository = commentRepository;

  @override
  Future<Either<Failure, List<Comment>>> call(GetCommentsParams params) async {
    return await _commentRepository.getComments(params);
  }
}

class GetCommentsParams extends Equatable {
  final String taskId;

  const GetCommentsParams({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
