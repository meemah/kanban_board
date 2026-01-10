import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';

import '../models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(String taskId);
  Future<CommentModel> addComment(AddCommentParams addCommentParams);
}

class CommentRemoteDatasourceImpl implements CommentRemoteDataSource {
  final NetworkService networkService;

  CommentRemoteDatasourceImpl({required this.networkService});

  @override
  Future<List<CommentModel>> getComments(String taskId) async {
    final response = await networkService.get(
      ApiConstants.commentsEndpoint,
      queryParameters: {'task_id': taskId},
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
