import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';

void main() {
  group('TaskTimerEntity', () {
    final taskEntity = TaskEntity(
      id: '1',
      content: 'Test Task',
      createdAt: DateTime(2024, 1, 1),
    );

    test('currentElapsedSeconds returns totalSeconds when not running', () {
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: false,
        taskEntity: taskEntity,
      );

      expect(timer.currentElapsedSeconds, 100);
    });

    test('currentElapsedSeconds calculates elapsed time when running', () {
      final startTime = DateTime.now().subtract(Duration(seconds: 10));
      final timer = TaskTimerEntity(
        totalSeconds: 50,
        startTime: startTime,
        isRunning: true,
        taskEntity: taskEntity,
      );

      final elapsed = timer.currentElapsedSeconds;
      expect(elapsed, greaterThanOrEqualTo(60)); // 50 + ~10
      expect(elapsed, lessThan(65)); // Allow some tolerance
    });

    test('copyWith creates new instance with updated values', () {
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: false,
        taskEntity: taskEntity,
      );

      final updated = timer.copyWith(totalSeconds: 200, isRunning: true);

      expect(updated.totalSeconds, 200);
      expect(updated.isRunning, true);
      expect(updated.taskEntity, taskEntity);
    });

    test('pause() saves elapsed time and stops running', () {
      final startTime = DateTime.now().subtract(Duration(seconds: 5));
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        startTime: startTime,
        isRunning: true,
        taskEntity: taskEntity,
      );

      final paused = timer.pause();

      expect(paused.isRunning, false);
      expect(paused.totalSeconds, greaterThanOrEqualTo(105));
    });

    test('resume() starts timer with new start time', () {
      final timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: false,
        taskEntity: taskEntity,
      );

      final resumed = timer.resume();

      expect(resumed.isRunning, true);
      expect(resumed.startTime, isNotNull);
      expect(resumed.totalSeconds, 100);
    });

    test('props includes all fields for equality comparison', () {
      final timer1 = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: true,
        startTime: DateTime(2024, 1, 1),
        taskEntity: taskEntity,
      );

      final timer2 = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: true,
        startTime: DateTime(2024, 1, 1),
        taskEntity: taskEntity,
      );

      expect(timer1, equals(timer2));
    });
  });

  group('TaskEntity', () {
    test('creates task with required fields', () {
      final task = TaskEntity(
        id: '1',
        content: 'Test Task',
        createdAt: DateTime(2024, 1, 1),
      );

      expect(task.id, '1');
      expect(task.content, 'Test Task');
      expect(task.isCompleted, false);
      expect(task.completedAt, null);
    });

    test('copyWith updates specified fields', () {
      final task = TaskEntity(
        id: '1',
        content: 'Test Task',
        createdAt: DateTime(2024, 1, 1),
      );

      final updated = task.copyWith(
        content: 'Updated Task',
        isCompleted: true,
        completedAt: DateTime(2024, 1, 2),
      );

      expect(updated.id, '1');
      expect(updated.content, 'Updated Task');
      expect(updated.isCompleted, true);
      expect(updated.completedAt, DateTime(2024, 1, 2));
    });
  });
}
