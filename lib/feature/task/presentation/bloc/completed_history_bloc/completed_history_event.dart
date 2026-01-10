part of 'completed_history_bloc.dart';

sealed class CompletedHistoryEvent extends Equatable {
  const CompletedHistoryEvent();

  @override
  List<Object> get props => [];
}

final class GetCompletedHistoryEvent extends CompletedHistoryEvent {}
