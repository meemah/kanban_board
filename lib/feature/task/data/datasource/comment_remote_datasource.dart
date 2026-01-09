import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';

import '../models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(String taskId);
  Future<CommentModel> addComment(String taskId, String content);
}

class TaskRemoteDataSourceImpl implements CommentRemoteDataSource {
  final NetworkService networkService;

  TaskRemoteDataSourceImpl({required this.networkService});

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
  Future<CommentModel> addComment(String taskId, String content) async {
    final response = await networkService.post(
      ApiConstants.commentsEndpoint,
      data: {'task_id': taskId, 'content': content},
    );
    return CommentModel.fromJson(response.data);
  }
}
