import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/util/usecase/usecase.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';

part 'completed_history_event.dart';
part 'completed_history_state.dart';

class CompletedHistoryBloc
    extends Bloc<CompletedHistoryEvent, CompletedHistoryState> {
  final GetTasksUsecase getTasksUsecase;
  CompletedHistoryBloc(this.getTasksUsecase)
    : super(CompletedHistoryInitial()) {
    on<GetCompletedHistoryEvent>(_onGetCompletedEvent);
  }
  _onGetCompletedEvent(
    GetCompletedHistoryEvent event,
    Emitter<CompletedHistoryState> emit,
  ) async {
    try {
      emit(CompletedHistoryLoading());
      var result = await getTasksUsecase.call(NoParams());
      result.fold(
        (error) => emit(CompletedHistoryFailure(errorMessage: error.message)),
        (data) => emit(
          CompletedHistorySuccess(
            completedTasks: data.where((item) => item.isCompleted).toList(),
          ),
        ),
      );
    } catch (e) {
      emit(CompletedHistoryFailure(errorMessage: "Opps, an error occured"));
    }
  }
}
