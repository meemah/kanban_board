import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_completed_tasks_usecase.dart';
import 'package:kanban_board/generated/l10n.dart';

part 'completed_history_event.dart';
part 'completed_history_state.dart';

class CompletedHistoryBloc
    extends Bloc<CompletedHistoryEvent, CompletedHistoryState> {
  final GetCompletedTasksUsecase getCompletedTasksUsecase;
  CompletedHistoryBloc(this.getCompletedTasksUsecase)
    : super(CompletedHistoryInitial()) {
    on<GetCompletedHistoryEvent>(_onGetCompletedEvent);
  }
  _onGetCompletedEvent(
    GetCompletedHistoryEvent event,
    Emitter<CompletedHistoryState> emit,
  ) async {
    try {
      emit(CompletedHistoryLoading());
      var result = getCompletedTasksUsecase.call();
      result.fold(
        (error) => emit(
          CompletedHistoryFailure(errorMessage: S.current.oppsErrorOccured),
        ),
        (data) => emit(CompletedHistorySuccess(completedTasks: data)),
      );
    } catch (e) {
      emit(CompletedHistoryFailure(errorMessage: S.current.oppsErrorOccured));
    }
  }
}
