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
    on<TaskDetailEvent>((event, emit) {
      on<AddCommentEvent>(_onAddComment);
    });
  }

  _onAddComment(AddCommentEvent event, Emitter<TaskDetailState> emit) async {
    var response = await _addComentUsecase.call(event.params);
    // response.fold(
    //   (error) => emit(GetCommentsFailure(error.message)),
    //   (data) => emit(GetCommentsSuccess(data)),
    // );
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
