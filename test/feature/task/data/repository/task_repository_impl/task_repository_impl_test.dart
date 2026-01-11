import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/data/datasource/task_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/models/task_model/task_model.dart';
import 'package:kanban_board/feature/task/data/repository/task_repository_impl/task_repository_impl.dart';
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'task_repository_impl_test.mocks.dart';

@GenerateMocks([TaskRemoteDataSource])
void main() {
  group('TaskRepositoryImpl', () {
    late TaskRepositoryImpl repository;
    late MockTaskRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockTaskRemoteDataSource();
      repository = TaskRepositoryImpl(remoteDataSource: mockRemoteDataSource);
    });

    group('getTasks', () {
      final tTaskModels = [
        TaskModel(
          id: '1',
          content: 'Task 1',
          description: 'Description 1',
          createdAt: DateTime(2024, 1, 1),
          isCompleted: false,
        ),
        TaskModel(
          id: '2',
          content: 'Task 2',
          createdAt: DateTime(2024, 1, 2),
          isCompleted: true,
          completedAt: DateTime(2024, 1, 3),
        ),
      ];

      test('should return list of task entities when successful', () async {
        when(
          mockRemoteDataSource.getTasks(),
        ).thenAnswer((_) async => tTaskModels);

        final result = await repository.getTasks();

        verify(mockRemoteDataSource.getTasks());
        expect(result.isRight(), true);
        result.fold((_) => fail('Should return right'), (tasks) {
          expect(tasks.length, 2);
          expect(tasks[0].id, '1');
          expect(tasks[0].content, 'Task 1');
          expect(tasks[0].isCompleted, false);
          expect(tasks[1].id, '2');
          expect(tasks[1].isCompleted, true);
        });
      });

      test('should return ServerFailure when fetching tasks fails', () async {
        when(
          mockRemoteDataSource.getTasks(),
        ).thenThrow(Exception('Network error'));

        final result = await repository.getTasks();

        expect(result.isLeft(), true);
      });
    });

    group('createTask', () {
      final tParams = UpsertTaskParams(
        content: 'New Task',
        description: 'Task description',
      );
      final tTaskModel = TaskModel(
        id: '1',
        content: 'New Task',
        description: 'Task description',
        createdAt: DateTime(2024, 1, 1),
      );

      test('should return created task entity when successful', () async {
        when(
          mockRemoteDataSource.createTask(upsertTaskParams: tParams),
        ).thenAnswer((_) async => tTaskModel);

        final result = await repository.createTask(upsertTaskParams: tParams);

        verify(mockRemoteDataSource.createTask(upsertTaskParams: tParams));
        expect(result.isRight(), true);
        result.fold((_) => fail('Should return right'), (task) {
          expect(task.id, '1');
          expect(task.content, 'New Task');
          expect(task.description, 'Task description');
        });
      });

      test('should return ServerFailure when creation fails', () async {
        when(
          mockRemoteDataSource.createTask(upsertTaskParams: tParams),
        ).thenThrow(Exception('Failed to create'));

        final result = await repository.createTask(upsertTaskParams: tParams);

        expect(result.isLeft(), true);
      });
    });

    group('updateTask', () {
      final tParams = UpsertTaskParams(
        id: '1',
        content: 'Updated Task',
        description: 'Updated description',
      );
      final tTaskModel = TaskModel(
        id: '1',
        content: 'Updated Task',
        description: 'Updated description',
        createdAt: DateTime(2024, 1, 1),
      );

      test('should return updated task entity when successful', () async {
        when(
          mockRemoteDataSource.updateTask(upsertTaskParams: tParams),
        ).thenAnswer((_) async => tTaskModel);

        final result = await repository.updateTask(upsertTaskParams: tParams);

        verify(mockRemoteDataSource.updateTask(upsertTaskParams: tParams));
        expect(result.isRight(), true);
        result.fold((_) => fail('Should return right'), (task) {
          expect(task.id, '1');
          expect(task.content, 'Updated Task');
        });
      });

      test('should return ServerFailure when update fails', () async {
        when(
          mockRemoteDataSource.updateTask(upsertTaskParams: tParams),
        ).thenThrow(Exception('Update failed'));

        final result = await repository.updateTask(upsertTaskParams: tParams);

        expect(result.isLeft(), true);
      });
    });

    group('completeTask', () {
      test('should return true when task is completed successfully', () async {
        when(
          mockRemoteDataSource.completeTask('1'),
        ).thenAnswer((_) async => Future.value());

        final result = await repository.completeTask('1');

        verify(mockRemoteDataSource.completeTask('1'));
        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should return right'),
          (success) => expect(success, true),
        );
      });

      test('should return ServerFailure when completing task fails', () async {
        when(
          mockRemoteDataSource.completeTask('1'),
        ).thenThrow(Exception('Failed to complete'));

        final result = await repository.completeTask('1');

        expect(result.isLeft(), true);
      });
    });
  });
}
