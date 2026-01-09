import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';

import '../models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(GetCommentsParams getCommentParams);
  Future<CommentModel> addComment(AddCommentParams addCommentParams);
}

class TaskRemoteDataSourceImpl implements CommentRemoteDataSource {
  final NetworkService networkService;

  TaskRemoteDataSourceImpl({required this.networkService});

  @override
  Future<List<CommentModel>> getComments(
    GetCommentsParams getCommentParams,
  ) async {
    final response = await networkService.get(
      ApiConstants.commentsEndpoint,
      queryParameters: {'task_id': getCommentParams.taskId},
    );
    final List<dynamic> data = response.data;
    return data.map((json) => CommentModel.fromJson(json)).toList();
  }

  @override
  Future<CommentModel> addComment(AddCommentParams addCommentParams) async {
    final response = await networkService.post(
      ApiConstants.commentsEndpoint,
      data: {
        'task_id': addCommentParams.taskId,
        'content': addCommentParams.content,
      },
    );
    return CommentModel.fromJson(response.data);
  }
}
