import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/upsert_task_usecase.dart';

import '../../../../../core/util/usecase/usecase.dart';

class MoveTaskUseCase implements UseCase<TaskEntity, MoveTaskUsecase> {
  final TaskRepository taskRepo;
  final TimerRepository timerRepo;

  MoveTaskUseCase({required this.taskRepo, required this.timerRepo});

  @override
  Future<Either<Failure, TaskEntity>> call(MoveTaskUsecase params) async {
    try {
      TaskEntity task = params.taskEntity;
      TaskStatus status = params.status;
      final timer = timerRepo.getTimer(task.id);

      switch (status) {
        case TaskStatus.todo:
          if (timer != null && timer.isRunning) {
            await timerRepo.pauseTimer(timer);
          }
          return _updateTask(task, 1);

        case TaskStatus.inprogess:
          if (timer == null || !timer.isRunning) {
            if (timer != null && !timer.isRunning) {
              await timerRepo.resumeTimer(timer);
            } else {
              await timerRepo.startTimer(task.id);
            }
          }

          return _updateTask(task, 2);

        case TaskStatus.completed:
          if (timer != null) {
            await timerRepo.stopTimer(timer);
          }

          final result = await taskRepo.completeTask(task.id);

          return result.fold((failure) => Left(failure), (_) => Right(task));
      }
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, TaskEntity>> _updateTask(
    TaskEntity task,
    int priority,
  ) async {
    return await taskRepo.updateTask(
      upsertTaskParams: UpsertTaskParams(
        content: task.content,
        id: task.id,
        priority: priority,
        description: task.description,
      ),
    );
  }
}

class MoveTaskUsecase extends Equatable {
  final TaskEntity taskEntity;
  final TaskStatus status;

  const MoveTaskUsecase({required this.taskEntity, required this.status});

  @override
  List<Object?> get props => [taskEntity, status];
}
