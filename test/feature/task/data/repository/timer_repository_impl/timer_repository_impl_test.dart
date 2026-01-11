import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/data/datasource/timer_local_datasource.dart';
import 'package:kanban_board/feature/task/data/models/task_model/task_model.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';
import 'package:kanban_board/feature/task/data/repository/timer_repository_impl/timer_repository_impl.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'timer_repository_impl_test.mocks.dart';

@GenerateMocks([TimerLocalDatasource])
void main() {
  group('TimerRepositoryImpl', () {
    late TimerRepositoryImpl repository;
    late MockTimerLocalDatasource mockLocalDataSource;

    setUp(() {
      mockLocalDataSource = MockTimerLocalDatasource();
      repository = TimerRepositoryImpl(mockLocalDataSource);
    });

    final tTask = TaskEntity(
      id: '1',
      content: 'Test Task',
      createdAt: DateTime(2024, 1, 1),
    );

    final tTaskModel = TaskModel(
      id: '1',
      content: 'Test Task',
      createdAt: DateTime(2024, 1, 1),
    );

    final tTimerModel = TaskTimerModel(
      taskModel: tTaskModel,
      totalSeconds: 100,
      isRunning: true,
      startTime: DateTime(2024, 1, 1, 10, 0),
    );

    group('getTimer', () {
      test('should return timer entity when timer exists', () {
        when(mockLocalDataSource.getTimer('1')).thenReturn(tTimerModel);

        final result = repository.getTimer('1');

        verify(mockLocalDataSource.getTimer('1'));
        expect(result, isNotNull);
        expect(result!.taskEntity.id, '1');
        expect(result.totalSeconds, 100);
        expect(result.isRunning, true);
      });

      test('should return null when timer does not exist', () {
        when(mockLocalDataSource.getTimer('1')).thenReturn(null);

        final result = repository.getTimer('1');

        verify(mockLocalDataSource.getTimer('1'));
        expect(result, isNull);
      });

      test('should return null when exception is thrown', () {
        when(mockLocalDataSource.getTimer('1')).thenThrow(Exception('Error'));

        final result = repository.getTimer('1');

        expect(result, isNull);
      });
    });

    group('startTimer', () {
      test('should return DatabaseFailure when saving fails', () async {
        when(
          mockLocalDataSource.saveTimer(any),
        ).thenThrow(Exception('Save failed'));

        final result = await repository.startTimer(tTask);

        expect(result.isLeft(), true);
      });
    });

    group('stopTimer', () {
      test('should return DatabaseFailure when stopping fails', () async {
        final timer = TaskTimerEntity(
          taskEntity: tTask,
          totalSeconds: 100,
          isRunning: true,
        );
        when(
          mockLocalDataSource.saveTimer(any),
        ).thenThrow(Exception('Stop failed'));

        final result = await repository.stopTimer(timer);

        expect(result.isLeft(), true);
      });
    });

    group('pauseTimer', () {
      test('should return DatabaseFailure when pausing fails', () async {
        final timer = TaskTimerEntity(
          taskEntity: tTask,
          totalSeconds: 100,
          isRunning: true,
        );
        when(
          mockLocalDataSource.saveTimer(any),
        ).thenThrow(Exception('Pause failed'));

        final result = await repository.pauseTimer(timer);

        expect(result.isLeft(), true);
      });
    });

    group('resumeTimer', () {
      test('should return DatabaseFailure when resuming fails', () async {
        final timer = TaskTimerEntity(
          taskEntity: tTask,
          totalSeconds: 100,
          isRunning: false,
        );
        when(
          mockLocalDataSource.saveTimer(any),
        ).thenThrow(Exception('Resume failed'));

        final result = await repository.resumeTimer(timer);

        expect(result.isLeft(), true);
      });
    });

    group('clearTimer', () {
      test('should delete timer successfully', () async {
        when(
          mockLocalDataSource.deleteTimer('1'),
        ).thenAnswer((_) async => Future.value());

        final result = await repository.clearTimer('1');

        verify(mockLocalDataSource.deleteTimer('1'));
        expect(result.isRight(), true);
      });

      test('should return DatabaseFailure when deletion fails', () async {
        when(
          mockLocalDataSource.deleteTimer('1'),
        ).thenThrow(Exception('Delete failed'));

        final result = await repository.clearTimer('1');

        expect(result.isLeft(), true);
      });
    });

    group('getAllCompletedTimers', () {
      test('should return only completed timers', () {
        final completedTask = tTaskModel.copyWith(
          isCompleted: true,
          completedAt: DateTime(2024, 1, 2),
        );
        final completedTimer = TaskTimerModel(
          taskModel: completedTask,
          totalSeconds: 200,
          isRunning: false,
        );
        final activeTimer = TaskTimerModel(
          taskModel: tTaskModel,
          totalSeconds: 100,
          isRunning: true,
        );

        when(
          mockLocalDataSource.getAllTimers(),
        ).thenReturn([completedTimer, activeTimer, null]);

        final result = repository.getAllCompletedTimers();

        verify(mockLocalDataSource.getAllTimers());
        expect(result.isRight(), true);
        result.fold((_) => fail('Should return right'), (timers) {
          expect(timers.length, 1);
          expect(timers[0].taskEntity.isCompleted, true);
          expect(timers[0].totalSeconds, 200);
        });
      });

      test('should return empty list when no completed timers', () {
        when(mockLocalDataSource.getAllTimers()).thenReturn([]);

        final result = repository.getAllCompletedTimers();

        expect(result.isRight(), true);
        result.fold(
          (_) => fail('Should return right'),
          (timers) => expect(timers, isEmpty),
        );
      });

      test('should return DatabaseFailure when fetching fails', () {
        when(
          mockLocalDataSource.getAllTimers(),
        ).thenThrow(Exception('Fetch failed'));

        final result = repository.getAllCompletedTimers();

        expect(result.isLeft(), true);
      });
    });
  });
}
