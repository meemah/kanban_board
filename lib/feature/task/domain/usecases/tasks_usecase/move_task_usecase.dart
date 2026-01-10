import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';

import '../../../../../core/util/usecase/usecase.dart';

class MoveTaskUseCase implements UseCase<TaskEntity, MoveTaskParams> {
  final TaskRepository taskRepo;
  final TimerRepository timerRepo;

  MoveTaskUseCase({required this.taskRepo, required this.timerRepo});

  @override
  Future<Either<Failure, TaskEntity>> call(MoveTaskParams params) async {
    try {
      TaskEntity task = params.taskEntity;
      TaskStatus status = params.status;
      final timer = timerRepo.getTimer(task.id);

      switch (status) {
        case TaskStatus.todo:
          if (timer != null && timer.isRunning) {
            await timerRepo.pauseTimer(timer);
          }
          return Right(task);

        case TaskStatus.inprogess:
          if (timer == null || !timer.isRunning) {
            if (timer != null && !timer.isRunning) {
              await timerRepo.resumeTimer(timer);
            } else {
              await timerRepo.startTimer(task.id);
            }
          }

          return Right(task);

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
}

class MoveTaskParams extends Equatable {
  final TaskEntity taskEntity;
  final TaskStatus status;

  const MoveTaskParams({required this.taskEntity, required this.status});

  @override
  List<Object?> get props => [taskEntity, status];
}
