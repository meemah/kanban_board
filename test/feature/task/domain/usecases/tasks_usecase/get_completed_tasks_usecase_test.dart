import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_completed_tasks_usecase.dart';
import 'package:mockito/mockito.dart';

import 'get_task_status_usecase_test.mocks.dart';

void main() {
  group('GetCompletedTasksUsecase', () {
    late MockTimerRepository mockRepo;
    late GetCompletedTasksUsecase usecase;

    setUp(() {
      mockRepo = MockTimerRepository();
      usecase = GetCompletedTasksUsecase(mockRepo);
    });

    test('returns list of completed task timers', () {
      final task1 = TaskEntity(
        id: '1',
        content: 'Task 1',
        createdAt: DateTime(2024, 1, 1),
        isCompleted: true,
      );
      final task2 = TaskEntity(
        id: '2',
        content: 'Task 2',
        createdAt: DateTime(2024, 1, 2),
        isCompleted: true,
      );
      final timers = [
        TaskTimerEntity(totalSeconds: 100, isRunning: false, taskEntity: task1),
        TaskTimerEntity(totalSeconds: 200, isRunning: false, taskEntity: task2),
      ];

      when(mockRepo.getAllCompletedTimers()).thenReturn(Right(timers));

      final result = usecase();

      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) => expect(r, timers));
    });

    test('returns failure on error', () {
      when(
        mockRepo.getAllCompletedTimers(),
      ).thenReturn(Left(ServerFailure('Error')));

      final result = usecase();

      expect(result.isLeft(), true);
    });
  });
}
