part of 'completed_history_bloc.dart';

sealed class CompletedHistoryState extends Equatable {
  const CompletedHistoryState();

  @override
  List<Object> get props => [];
}

final class CompletedHistoryInitial extends CompletedHistoryState {}

final class CompletedHistoryLoading extends CompletedHistoryState {}

final class CompletedHistoryFailure extends CompletedHistoryState {
  final String message;

  const CompletedHistoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CompletedHistorySuccess extends CompletedHistoryState {
  final List<TaskEntity> data;

  const CompletedHistorySuccess({required this.data});

  @override
  List<Object> get props => [data];
}
