import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/data/datasource/task_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/models/task_model/task_model.dart';
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'comment_remote_datasource_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  group('TaskRemoteDataSourceImpl', () {
    late TaskRemoteDataSourceImpl dataSource;
    late MockNetworkService mockNetworkService;

    setUp(() {
      mockNetworkService = MockNetworkService();
      dataSource = TaskRemoteDataSourceImpl(networkService: mockNetworkService);
    });

    group('getTasks', () {
      final tTasksJson = [
        {
          'id': '1',
          'content': 'Task 1',
          'description': 'Description 1',
          'created_at': '2026-01-11T00:00:00Z',
          'completed_at': null,
          'is_completed': false,
        },
        {
          'id': '2',
          'content': 'Task 2',
          'description': 'Description 2',
          'created_at': '2026-01-11T01:00:00Z',
          'completed_at': null,
          'is_completed': false,
        },
      ];

      test('should return list of TaskModel when call is successful', () async {
        when(mockNetworkService.get(any)).thenAnswer(
          (_) async => Response(
            data: tTasksJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.getTasks();

        verify(mockNetworkService.get(ApiConstants.tasksEndpoint)).called(1);
        expect(result, isA<List<TaskModel>>());
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[1].id, '2');
      });

      test('should throw exception when networkService throws', () async {
        when(mockNetworkService.get(any)).thenThrow(Exception('Network error'));

        final call = dataSource.getTasks;

        expect(() => call(), throwsException);
      });

      test('should return empty list when response data is empty', () async {
        when(mockNetworkService.get(any)).thenAnswer(
          (_) async => Response(
            data: [],
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.getTasks();

        expect(result, isEmpty);
      });
    });

    group('createTask', () {
      final tUpsertParams = UpsertTaskParams(
        content: 'New Task',
        description: 'Task description',
      );

      final tTaskJson = {
        'id': '1',
        'content': 'New Task',
        'description': 'Task description',
        'created_at': '2026-01-11T00:00:00Z',
        'completed_at': null,
        'is_completed': false,
      };

      test('should return TaskModel when call is successful', () async {
        when(mockNetworkService.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: tTaskJson,
            statusCode: 201,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.createTask(
          upsertTaskParams: tUpsertParams,
        );

        verify(
          mockNetworkService.post(
            ApiConstants.tasksEndpoint,
            data: {
              'content': tUpsertParams.content,
              'description': tUpsertParams.description,
            },
          ),
        ).called(1);

        expect(result, isA<TaskModel>());
        expect(result.id, '1');
        expect(result.content, 'New Task');
      });

      test('should throw exception when networkService throws', () async {
        when(
          mockNetworkService.post(any, data: anyNamed('data')),
        ).thenThrow(Exception('Network error'));

        final call = dataSource.createTask;

        expect(() => call(upsertTaskParams: tUpsertParams), throwsException);
      });
    });

    group('updateTask', () {
      final tUpsertParams = UpsertTaskParams(
        id: '1',
        content: 'Updated Task',
        description: 'Updated description',
      );

      final tTaskJson = {
        'id': '1',
        'content': 'Updated Task',
        'description': 'Updated description',
        'created_at': '2026-01-11T00:00:00Z',
        'completed_at': null,
        'is_completed': false,
      };

      test('should return TaskModel when update is successful', () async {
        when(mockNetworkService.post(any, data: anyNamed('data'))).thenAnswer(
          (_) async => Response(
            data: tTaskJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        final result = await dataSource.updateTask(
          upsertTaskParams: tUpsertParams,
        );

        verify(
          mockNetworkService.post(
            '${ApiConstants.tasksEndpoint}/1',
            data: {
              'content': tUpsertParams.content,
              'description': tUpsertParams.description,
            },
          ),
        ).called(1);

        expect(result, isA<TaskModel>());
        expect(result.content, 'Updated Task');
      });
    });

    group('completeTask', () {
      test('should call post with correct endpoint', () async {
        when(mockNetworkService.post(any)).thenAnswer(
          (_) async => Response(
            data: null,
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ),
        );

        await dataSource.completeTask('1');

        verify(
          mockNetworkService.post('${ApiConstants.tasksEndpoint}/1/close'),
        ).called(1);
      });

      test('should throw exception when networkService throws', () async {
        when(
          mockNetworkService.post(any),
        ).thenThrow(Exception('Network error'));

        final call = dataSource.completeTask;

        expect(() => call('1'), throwsException);
      });
    });
  });
}
