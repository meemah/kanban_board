part of 'completed_history_bloc.dart';

sealed class CompletedHistoryState extends Equatable {
  const CompletedHistoryState();

  @override
  List<Object> get props => [];
}

final class CompletedHistoryInitial extends CompletedHistoryState {}

final class CompletedHistoryLoading extends CompletedHistoryState {}

final class CompletedHistoryFailure extends CompletedHistoryState {
  final String errorMessage;

  const CompletedHistoryFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class CompletedHistorySuccess extends CompletedHistoryState {
  final List<TaskEntity> completedTasks;

  const CompletedHistorySuccess({required this.completedTasks});

  @override
  List<Object> get props => [completedTasks];
}
