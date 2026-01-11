import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:mockito/mockito.dart';

import 'get_comments_usecase_test.mocks.dart';

void main() {
  group('AddCommentUsecase', () {
    late MockCommentRepository mockRepo;
    late AddComentUsecase usecase;

    setUp(() {
      mockRepo = MockCommentRepository();
      usecase = AddComentUsecase(mockRepo);
    });

    test('adds comment successfully', () async {
      final params = AddCommentParams(taskId: 'task1', content: 'New comment');
      final comment = CommentEntity(
        id: '1',
        taskId: 'task1',
        content: 'New comment',
        postedAt: DateTime.now(),
      );

      when(mockRepo.addComment(params)).thenAnswer((_) async => Right(comment));

      final result = await usecase(params);

      expect(result.isRight(), true);
      verify(mockRepo.addComment(params)).called(1);
    });

    test('returns failure on error', () async {
      final params = AddCommentParams(taskId: 'task1', content: 'New comment');

      when(
        mockRepo.addComment(params),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      final result = await usecase(params);

      expect(result.isLeft(), true);
    });
  });
}
