import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/resume_timer_usecase.dart';
import 'package:mockito/mockito.dart';

import '../tasks_usecase/get_task_status_usecase_test.mocks.dart';

void main() {
  group('ResumeTimerUseCase', () {
    late MockTimerRepository mockRepo;
    late ResumeTimerUseCase usecase;
    late TaskTimerEntity timer;

    setUp(() {
      mockRepo = MockTimerRepository();
      usecase = ResumeTimerUseCase(timerRepo: mockRepo);
      final task = TaskEntity(
        id: '1',
        content: 'Test',
        createdAt: DateTime(2024, 1, 1),
      );
      timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: false,
        taskEntity: task,
      );
    });

    test('resumes timer and returns updated timer', () async {
      final resumedTimer = timer.copyWith(isRunning: true);
      when(mockRepo.resumeTimer(timer)).thenAnswer((_) async => Right(null));
      when(mockRepo.getTimer('1')).thenReturn(resumedTimer);

      final result = await usecase(timer);

      expect(result.isRight(), true);
      verify(mockRepo.resumeTimer(timer)).called(1);
      verify(mockRepo.getTimer('1')).called(1);
    });

    test('returns failure on exception', () async {
      when(mockRepo.resumeTimer(timer)).thenThrow(Exception('Error'));

      final result = await usecase(timer);

      expect(result.isLeft(), true);
    });
  });
}
