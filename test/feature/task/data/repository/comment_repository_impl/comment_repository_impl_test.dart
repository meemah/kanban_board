import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/data/datasource/comment_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/models/comment_model.dart';
import 'package:kanban_board/feature/task/data/repository/comment_repository_impl/comment_repository_impl.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comment_repository_impl_test.mocks.dart';

@GenerateMocks([CommentRemoteDataSource, Response])
void main() {
  group('CommentRepositoryImpl', () {
    late CommentRepositoryImpl repository;
    late MockCommentRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockCommentRemoteDataSource();
      repository = CommentRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
      );
    });

    group('getComments', () {
      final tCommentModels = [
        CommentModel(
          id: '1',
          taskId: 'task1',
          content: 'Comment 1',
          postedAt: DateTime(2024, 1, 1),
        ),
        CommentModel(
          id: '2',
          taskId: 'task1',
          content: 'Comment 2',
          postedAt: DateTime(2024, 1, 2),
        ),
      ];

      test('should return list of comment entities when successful', () async {
        when(
          mockRemoteDataSource.getComments('task1'),
        ).thenAnswer((_) async => tCommentModels);

        final result = await repository.getComments('task1');

        verify(mockRemoteDataSource.getComments('task1'));
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should return right'), (comments) {
          expect(comments.length, 2);
          expect(comments[0].id, '1');
          expect(comments[0].content, 'Comment 1');
          expect(comments[1].id, '2');
        });
      });

      test(
        'should return ServerFailure when remote data source throws exception',
        () async {
          when(
            mockRemoteDataSource.getComments('task1'),
          ).thenThrow(Exception('Network error'));

          final result = await repository.getComments('task1');

          verify(mockRemoteDataSource.getComments('task1'));
          expect(result.isLeft(), true);
          result.fold((failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, contains('Network error'));
          }, (_) => fail('Should return left'));
        },
      );

      test('should return empty list when no comments exist', () async {
        when(
          mockRemoteDataSource.getComments('task1'),
        ).thenAnswer((_) async => []);

        final result = await repository.getComments('task1');

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should return right'),
          (comments) => expect(comments, isEmpty),
        );
      });
    });

    group('addComment', () {
      final tParams = AddCommentParams(taskId: 'task1', content: 'New comment');
      final tCommentModel = CommentModel(
        id: '1',
        taskId: 'task1',
        content: 'New comment',
        postedAt: DateTime(2024, 1, 1),
      );

      test('should return comment entity when successfully added', () async {
        when(
          mockRemoteDataSource.addComment(tParams),
        ).thenAnswer((_) async => tCommentModel);

        final result = await repository.addComment(tParams);

        verify(mockRemoteDataSource.addComment(tParams));
        expect(result.isRight(), true);
        result.fold((_) => fail('Should return right'), (comment) {
          expect(comment.id, '1');
          expect(comment.taskId, 'task1');
          expect(comment.content, 'New comment');
        });
      });

      test('should return ServerFailure when adding comment fails', () async {
        when(
          mockRemoteDataSource.addComment(tParams),
        ).thenThrow(Exception('Failed to add comment'));

        final result = await repository.addComment(tParams);

        verify(mockRemoteDataSource.addComment(tParams));
        expect(result.isLeft(), true);
      });
    });
  });
}
