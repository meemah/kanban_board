import 'package:dartz/dartz.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/params/move_task_params.dart';
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

      TaskEntity updatedTask = task;

      switch (status) {
        case TaskStatus.todo:
          if (timer != null && timer.isRunning) {
            await timerRepo.pauseTimer(timer);
          }

          break;

        case TaskStatus.inProgress:
          if (timer == null) {
            await timerRepo.startTimer(task);
          } else {
            await timerRepo.resumeTimer(timer);
          }

          break;

        case TaskStatus.completed:
          if (timer != null) {
            await timerRepo.stopTimer(timer);
          }

          final result = await taskRepo.completeTask(updatedTask.id);

          return result.fold((failure) => Left(failure), (_) {
            return Right(updatedTask);
          });
      }

      return Right(updatedTask);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
