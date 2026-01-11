import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_task_status_usecase_test.mocks.dart';

@GenerateMocks([TimerRepository])
void main() {
  group('GetTaskStatusUsecase', () {
    late MockTimerRepository mockRepo;
    late GetTaskStatusUsecase usecase;
    late TaskEntity task;

    setUp(() {
      mockRepo = MockTimerRepository();
      usecase = GetTaskStatusUsecase(mockRepo);
      task = TaskEntity(
        id: '1',
        content: 'Test',
        createdAt: DateTime(2024, 1, 1),
      );
    });

    test('returns todo when no timer exists', () {
      when(mockRepo.getTimer('1')).thenReturn(null);

      final status = usecase(task);

      expect(status, TaskStatus.todo);
      verify(mockRepo.getTimer('1')).called(1);
    });

    test('returns inProgress when timer exists', () {
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: true,
        taskEntity: task,
      );
      when(mockRepo.getTimer('1')).thenReturn(timer);

      final status = usecase(task);

      expect(status, TaskStatus.inProgress);
      verify(mockRepo.getTimer('1')).called(1);
    });
  });
}
