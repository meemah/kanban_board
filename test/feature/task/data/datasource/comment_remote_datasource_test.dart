import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/data/datasource/comment_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/models/comment_model.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comment_remote_datasource_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  group('CommentRemoteDatasourceImpl', () {
    late CommentRemoteDatasourceImpl dataSource;
    late MockNetworkService mockNetworkService;

    setUp(() {
      mockNetworkService = MockNetworkService();
      dataSource = CommentRemoteDatasourceImpl(
        networkService: mockNetworkService,
      );
    });

    group('getComments', () {
      const tTaskId = 'task123';
      final tCommentsJson = [
        {
          'id': 'comment1',
          'task_id': tTaskId,
          'content': 'First comment',
          'posted_at': '2024-01-01T00:00:00Z',
        },
        {
          'id': 'comment2',
          'task_id': tTaskId,
          'content': 'Second comment',
          'posted_at': '2024-01-02T00:00:00Z',
        },
      ];

      test(
        'should return list of CommentModel when call is successful',
        () async {
          when(
            mockNetworkService.get(
              any,
              queryParameters: anyNamed('queryParameters'),
            ),
          ).thenAnswer(
            (_) async => Response(
              data: tCommentsJson,
              statusCode: 200,
              requestOptions: RequestOptions(path: ''),
            ),
          );

          final result = await dataSource.getComments(tTaskId);

          verify(
            mockNetworkService.get(
              ApiConstants.commentsEndpoint,
              queryParameters: {'task_id': tTaskId},
            ),
          );
          expect(result, isA<List<CommentModel>>());
          expect(result.length, 2);
          expect(result[0].id, 'comment1');
          expect(result[1].id, 'comment2');
        },
      );

      test('should call networkService.get with correct parameters', () async {
        when(
          mockNetworkService.get(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: [],
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await dataSource.getComments(tTaskId);

        verify(
          mockNetworkService.get(
            ApiConstants.commentsEndpoint,
            queryParameters: {'task_id': tTaskId},
          ),
        ).called(1);
      });

      test('should throw exception when networkService throws', () async {
        when(
          mockNetworkService.get(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenThrow(Exception('Network error'));

        final call = dataSource.getComments;

        expect(() => call(tTaskId), throwsException);
      });

      test('should return empty list when response data is empty', () async {
        when(
          mockNetworkService.get(
            any,
            queryParameters: anyNamed('queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: [],
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.getComments(tTaskId);

        expect(result, isEmpty);
      });
    });

    group('addComment', () {
      final tAddCommentParams = AddCommentParams(
        taskId: 'task123',
        content: 'New comment',
      );

      final tCommentJson = {
        'id': 'comment1',
        'task_id': 'task123',
        'content': 'New comment',
        'posted_at': '2024-01-01T00:00:00Z',
      };

      test('should return CommentModel when call is successful', () async {
        when(mockNetworkService.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: tCommentJson,
            statusCode: 201,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.addComment(tAddCommentParams);

        verify(
          mockNetworkService.post(
            ApiConstants.commentsEndpoint,
            data: {
              'task_id': tAddCommentParams.taskId,
              'content': tAddCommentParams.content,
            },
          ),
        );
        expect(result, isA<CommentModel>());
        expect(result.id, 'comment1');
        expect(result.content, 'New comment');
      });

      test('should call networkService.post with correct parameters', () async {
        when(mockNetworkService.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: tCommentJson,
            statusCode: 201,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await dataSource.addComment(tAddCommentParams);

        verify(
          mockNetworkService.post(
            ApiConstants.commentsEndpoint,
            data: {
              'task_id': tAddCommentParams.taskId,
              'content': tAddCommentParams.content,
            },
          ),
        ).called(1);
      });

      test('should throw exception when networkService throws', () async {
        when(
          mockNetworkService.post(any, data: anyNamed('data')),
        ).thenThrow(Exception('Network error'));

        final call = dataSource.addComment;

        expect(() => call(tAddCommentParams), throwsException);
      });
    });
  });
}
