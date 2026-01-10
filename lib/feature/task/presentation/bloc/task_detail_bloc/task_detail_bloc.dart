import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final GetCommentsUsecase _getCommentsUsecase;
  final AddComentUsecase _addComentUsecase;
  TaskDetailBloc(this._addComentUsecase, this._getCommentsUsecase)
    : super(TaskDetailInitial()) {
    on<AddCommentEvent>(_onAddCommentOptimistic);
    on<GetCommentsEvent>(_onGetComments);
  }

  _onAddCommentOptimistic(
    AddCommentEvent event,
    Emitter<TaskDetailState> emit,
  ) async {
    try {
      final currentState = state;

      if (currentState is! GetCommentsSuccess) return;

      final tempId = DateTime.now().millisecondsSinceEpoch.toString();

      final optimisticComment = CommentEntity(
        id: tempId,
        taskId: event.params.taskId,
        content: event.params.content,
        postedAt: DateTime.now(),
        isPending: true,
      );

      emit(GetCommentsSuccess([...currentState.comments, optimisticComment]));

      final result = await _addComentUsecase(event.params);

      if (emit.isDone) return;

      result.fold(
        (failure) {
          emit(GetCommentsSuccess(currentState.comments));
          emit(AddCommentFailure(failure.message));
        },
        (savedComment) {
          final updatedComments =
              currentState.comments.where((c) => c.id != tempId).toList()
                ..add(savedComment);

          emit(GetCommentsSuccess(updatedComments));
        },
      );
    } catch (e) {}
  }

  _onGetComments(GetCommentsEvent event, Emitter<TaskDetailState> emit) async {
    try {
      emit(GetCommentsLoading());
      var response = await _getCommentsUsecase.call(event.params);
      response.fold(
        (error) => emit(GetCommentsFailure(error.message)),
        (data) => emit(GetCommentsSuccess(data)),
      );
    } catch (e) {
      emit(GetCommentsFailure("Opps, an error occured"));
    }
  }
}
