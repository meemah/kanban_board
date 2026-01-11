import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/params/move_task_params.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/move_task_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_task_status_usecase_test.mocks.dart';
import 'move_task_usecase_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  group('MoveTaskUseCase', () {
    late MockTaskRepository mockTaskRepo;
    late MockTimerRepository mockTimerRepo;
    late MoveTaskUseCase usecase;
    late TaskEntity task;
    late TaskTimerEntity timer;

    setUp(() {
      mockTaskRepo = MockTaskRepository();
      mockTimerRepo = MockTimerRepository();
      usecase = MoveTaskUseCase(
        taskRepo: mockTaskRepo,
        timerRepo: mockTimerRepo,
      );
      task = TaskEntity(
        id: '1',
        content: 'Test',
        createdAt: DateTime(2024, 1, 1),
      );
      timer = TaskTimerEntity(
        totalSeconds: 100,
        isRunning: true,
        startTime: DateTime.now(),
        taskEntity: task,
      );
    });

    test('moving to todo pauses running timer', () async {
      when(mockTimerRepo.getTimer('1')).thenReturn(timer);
      when(mockTimerRepo.pauseTimer(any)).thenAnswer((_) async => Right(null));

      final params = MoveTaskParams(taskEntity: task, status: TaskStatus.todo);

      final result = await usecase(params);

      expect(result.isRight(), true);
      verify(mockTimerRepo.pauseTimer(timer)).called(1);
    });

    test('moving to inProgress starts timer when none exists', () async {
      when(mockTimerRepo.getTimer('1')).thenReturn(null);
      when(mockTimerRepo.startTimer(any)).thenAnswer((_) async => Right(null));

      final params = MoveTaskParams(
        taskEntity: task,
        status: TaskStatus.inProgress,
      );

      final result = await usecase(params);

      expect(result.isRight(), true);
      verify(mockTimerRepo.startTimer(task)).called(1);
    });

    test('moving to inProgress resumes existing timer', () async {
      final pausedTimer = timer.copyWith(isRunning: false);
      when(mockTimerRepo.getTimer('1')).thenReturn(pausedTimer);
      when(mockTimerRepo.resumeTimer(any)).thenAnswer((_) async => Right(null));

      final params = MoveTaskParams(
        taskEntity: task,
        status: TaskStatus.inProgress,
      );

      final result = await usecase(params);

      expect(result.isRight(), true);
      verify(mockTimerRepo.resumeTimer(pausedTimer)).called(1);
    });

    test('moving to completed stops timer and completes task', () async {
      when(mockTimerRepo.getTimer('1')).thenReturn(timer);
      when(mockTimerRepo.stopTimer(any)).thenAnswer((_) async => Right(null));
      when(mockTaskRepo.completeTask('1')).thenAnswer((_) async => Right(true));

      final params = MoveTaskParams(
        taskEntity: task,
        status: TaskStatus.completed,
      );

      final result = await usecase(params);

      expect(result.isRight(), true);
      verify(mockTimerRepo.stopTimer(timer)).called(1);
      verify(mockTaskRepo.completeTask('1')).called(1);
    });

    test('returns failure when complete task fails', () async {
      when(mockTimerRepo.getTimer('1')).thenReturn(timer);
      when(mockTimerRepo.stopTimer(any)).thenAnswer((_) async => Right(null));
      when(
        mockTaskRepo.completeTask('1'),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      final params = MoveTaskParams(
        taskEntity: task,
        status: TaskStatus.completed,
      );

      final result = await usecase(params);

      expect(result.isLeft(), true);
    });
  });
}
