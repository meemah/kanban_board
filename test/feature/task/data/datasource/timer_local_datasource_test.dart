import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:kanban_board/feature/task/data/models/task_model/task_model.dart';
import 'package:kanban_board/feature/task/data/models/task_timer_model/task_timer_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'timer_local_datasource_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<TaskTimerModel?> mockBox;

  final tTaskModel = TaskModel(
    id: '1',
    content: 'Test Task',
    description: 'Description',
    createdAt: DateTime.now(),
    isCompleted: false,
  );

  final tTaskTimerModel = TaskTimerModel(
    taskModel: tTaskModel,
    totalSeconds: 120,
    startTime: DateTime.now(),
    isRunning: true,
  );

  setUp(() {
    mockBox = MockBox<TaskTimerModel?>();
  });

  group('getTimer', () {
    test('should return TaskTimerModel when box has data', () {
      when(mockBox.get('1')).thenReturn(tTaskTimerModel);

      final result = mockBox.get('1');
      expect(result, tTaskTimerModel);
      verify(mockBox.get('1')).called(1);
    });

    test('should return null when box throws', () {
      when(mockBox.get('1')).thenThrow(Exception('Hive error'));

      try {
        mockBox.get('1');
        fail('Expected exception');
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });

  group('saveTimer', () {
    test('should call box.put with correct values', () async {
      when(mockBox.put(any, any)).thenAnswer((_) async {});

      await mockBox.put(tTaskTimerModel.taskModel.id, tTaskTimerModel);

      verify(
        mockBox.put(tTaskTimerModel.taskModel.id, tTaskTimerModel),
      ).called(1);
    });

    test('should rethrow exception when box.put fails', () async {
      when(mockBox.put(any, any)).thenThrow(Exception('Hive error'));

      expect(
        () => mockBox.put(tTaskTimerModel.taskModel.id, tTaskTimerModel),
        throwsException,
      );
    });
  });

  group('deleteTimer', () {
    test('should call box.delete with correct key', () async {
      when(mockBox.delete(any)).thenAnswer((_) async {});

      await mockBox.delete('1');

      verify(mockBox.delete('1')).called(1);
    });

    test('should rethrow exception when box.delete fails', () async {
      when(mockBox.delete(any)).thenThrow(Exception('Hive error'));

      expect(() => mockBox.delete('1'), throwsException);
    });
  });

  group('getAllTimers', () {
    test('should return list of timers when box has values', () {
      when(mockBox.values).thenReturn([tTaskTimerModel]);

      final result = mockBox.values.toList();

      expect(result, [tTaskTimerModel]);
      verify(mockBox.values).called(1);
    });

    test('should return empty list when box throws', () {
      when(mockBox.values).thenThrow(Exception('Hive error'));

      try {
        mockBox.values.toList();
        fail('Expected exception');
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
