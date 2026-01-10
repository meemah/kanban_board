import 'package:equatable/equatable.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';

class MoveTaskParams extends Equatable {
  final TaskEntity taskEntity;
  final TaskStatus status;

  const MoveTaskParams({required this.taskEntity, required this.status});

  @override
  List<Object?> get props => [taskEntity, status];
}
