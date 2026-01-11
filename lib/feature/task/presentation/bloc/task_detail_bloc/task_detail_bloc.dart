import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/get_task_timer_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/pause_timer_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/resume_timer_usecase.dart';

import '../../../domain/entities/task_timer.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final GetTaskStatusUsecase _getTaskStatusUsecase;
  final ResumeTimerUseCase _resumeTimerUseCase;
  final PauseTimerUseCase _pauseTimerUseCase;
  final GetTaskTimerUsecase _getTaskTimerUsecase;
  TaskDetailBloc(
    this._getTaskStatusUsecase,
    this._pauseTimerUseCase,
    this._getTaskTimerUsecase,
    this._resumeTimerUseCase,
  ) : super(TaskDetailInitial()) {
    on<InitializeTaskDetailEvent>(_onInitializeTaskDetail);
    on<PauseTaskTimerEvent>(_onPauseTaskTimer);
    on<ResumeTaskTimerEvent>(_onResumeTaskTimer);
  }

  Future<void> _onInitializeTaskDetail(
    InitializeTaskDetailEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    final status = _getTaskStatusUsecase.call(event.task);
    final result = _getTaskTimerUsecase.call(event.task);
    result.fold(
      (error) => emit(TaskDetailFailure(error.message)),
      (data) =>
          emit(TaskDetailLoaded(task: event.task, status: status, timer: data)),
    );
  }

  Future<void> _onPauseTaskTimer(
    PauseTaskTimerEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    final current = state;
    if (current is! TaskDetailLoaded || current.timer == null) return;

    final result = await _pauseTimerUseCase(current.timer!);

    result.fold(
      (f) => emit(TaskDetailFailure(f.message)),
      (timer) => emit(current.copyWith(timer: timer)),
    );
  }

  Future<void> _onResumeTaskTimer(
    ResumeTaskTimerEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    final current = state;
    if (current is! TaskDetailLoaded || current.timer == null) return;

    final result = await _resumeTimerUseCase(current.timer!);

    result.fold(
      (f) => emit(TaskDetailFailure(f.message)),
      (timer) => emit(current.copyWith(timer: timer)),
    );
  }
}
