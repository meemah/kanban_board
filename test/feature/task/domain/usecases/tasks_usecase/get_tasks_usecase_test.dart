import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';
import 'package:mockito/mockito.dart';

import 'move_task_usecase_test.mocks.dart';

void main() {
  group('GetActiveTasksUsecase', () {
    late MockTaskRepository mockRepo;
    late GetActiveTasksUsecase usecase;

    setUp(() {
      mockRepo = MockTaskRepository();
      usecase = GetActiveTasksUsecase(mockRepo);
    });

    test('returns list of active tasks', () async {
      final tasks = [
        TaskEntity(id: '1', content: 'Task 1', createdAt: DateTime(2024, 1, 1)),
        TaskEntity(id: '2', content: 'Task 2', createdAt: DateTime(2024, 1, 2)),
      ];

      when(mockRepo.getTasks()).thenAnswer((_) async => Right(tasks));

      final result = await usecase(NoParams());

      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) => expect(r, tasks));
    });

    test('returns failure on error', () async {
      when(
        mockRepo.getTasks(),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      final result = await usecase(NoParams());

      expect(result.isLeft(), true);
    });
  });
}
