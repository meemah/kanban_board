import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/get_task_timer_usecase.dart'
    show GetTaskTimerUsecase;
import 'package:mockito/mockito.dart';

import '../tasks_usecase/get_task_status_usecase_test.mocks.dart';

void main() {
  group('GetTaskTimerUsecase', () {
    late MockTimerRepository mockRepo;
    late GetTaskTimerUsecase usecase;
    late TaskEntity task;

    setUp(() {
      mockRepo = MockTimerRepository();
      usecase = GetTaskTimerUsecase(timerRepo: mockRepo);
      task = TaskEntity(
        id: '1',
        content: 'Test',
        createdAt: DateTime(2024, 1, 1),
      );
    });

    test('returns timer when it exists', () {
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: true,
        taskEntity: task,
      );
      when(mockRepo.getTimer('1')).thenReturn(timer);

      final result = usecase(task);

      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) => expect(r, timer));
    });

    test('returns null when timer does not exist', () {
      when(mockRepo.getTimer('1')).thenReturn(null);

      final result = usecase(task);

      expect(result.isRight(), true);
      result.fold((l) => fail('Should return right'), (r) => expect(r, null));
    });

    test('returns failure on exception', () {
      when(mockRepo.getTimer('1')).thenThrow(Exception('Error'));

      final result = usecase(task);

      expect(result.isLeft(), true);
    });
  });
}
