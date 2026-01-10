import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/error/failures.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/upsert_task_usecase.dart';

part 'upsert_task_event.dart';
part 'upsert_task_state.dart';

class UpsertTaskBloc extends Bloc<UpsertTaskEvent, UpsertTaskState> {
  final UpsertTaskUseCase _upsertTaskUseCase;
  UpsertTaskBloc(this._upsertTaskUseCase) : super(UpsertTaskInitial()) {
    on<UpsertTask>(_onUpsertTask);
  }

  Future<void> _onUpsertTask(
    UpsertTask event,
    Emitter<UpsertTaskState> emit,
  ) async {
    try {
      emit(UpsertTaskLoading());

      final Either<Failure, TaskEntity> result = await _upsertTaskUseCase(
        event.task,
      );

      result.fold(
        (failure) => emit(UpsertTaskFailure(failure.message)),
        (task) => emit(UpsertTaskSuccess(task)),
      );
    } catch (e) {
      emit(UpsertTaskFailure("Opps, an error occured"));
    }
  }
}
