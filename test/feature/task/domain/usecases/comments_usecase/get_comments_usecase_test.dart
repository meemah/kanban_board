import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/repositories/comment_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_comments_usecase_test.mocks.dart';

@GenerateMocks([CommentRepository])
void main() {
  group('GetCommentsUsecase', () {
    late MockCommentRepository mockRepo;
    late GetCommentsUsecase usecase;

    setUp(() {
      mockRepo = MockCommentRepository();
      usecase = GetCommentsUsecase(commentRepository: mockRepo);
    });

    test('returns list of comments for task', () async {
      final comments = [
        CommentEntity(
          id: '1',
          taskId: 'task1',
          content: 'Comment 1',
          postedAt: DateTime(2024, 1, 1),
        ),
        CommentEntity(
          id: '2',
          taskId: 'task1',
          content: 'Comment 2',
          postedAt: DateTime(2024, 1, 2),
        ),
      ];

      when(
        mockRepo.getComments('task1'),
      ).thenAnswer((_) async => Right(comments));

      final result = await usecase('task1');

      expect(result.isRight(), true);
      result.fold(
        (l) => fail('Should return right'),
        (r) => expect(r, comments),
      );
    });

    test('returns failure on error', () async {
      when(
        mockRepo.getComments('task1'),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      final result = await usecase('task1');

      expect(result.isLeft(), true);
    });
  });
}
