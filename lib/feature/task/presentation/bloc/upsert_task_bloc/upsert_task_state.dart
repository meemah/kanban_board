part of 'upsert_task_bloc.dart';

sealed class UpsertTaskState extends Equatable {
  const UpsertTaskState();

  @override
  List<Object> get props => [];
}

final class UpsertTaskInitial extends UpsertTaskState {}

final class UpsertTaskLoading extends UpsertTaskState {}

final class UpsertTaskSuccess extends UpsertTaskState {
  final TaskEntity task;

  const UpsertTaskSuccess(this.task);

  @override
  List<Object> get props => [task];
}

final class UpsertTaskFailure extends UpsertTaskState {
  final String errorMessage;

  const UpsertTaskFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
