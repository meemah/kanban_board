part of 'upsert_task_bloc.dart';

sealed class UpsertTaskEvent extends Equatable {
  const UpsertTaskEvent();

  @override
  List<Object> get props => [];
}

final class UpsertTask extends UpsertTaskEvent {
  final UpsertTaskParams task;

  const UpsertTask(this.task);

  @override
  List<Object> get props => [task];
}
