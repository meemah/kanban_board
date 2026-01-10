import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart';

import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> createTask({required UpsertTaskParams upsertTaskParams});
  Future<TaskModel> updateTask({required UpsertTaskParams upsertTaskParams});
  Future<void> completeTask(String id);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final NetworkService networkService;

  TaskRemoteDataSourceImpl({required this.networkService});

  @override
  Future<List<TaskModel>> getTasks() async {
    final response = await networkService.get(ApiConstants.tasksEndpoint);
    final List<dynamic> data = response.data;
    return data.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<TaskModel> createTask({
    required UpsertTaskParams upsertTaskParams,
  }) async {
    final data = {
      'content': upsertTaskParams.content,
      'description': upsertTaskParams.description,
      'priority': upsertTaskParams.priority,
    };
    data.removeWhere((key, value) => value == null);
    final response = await networkService.post(
      ApiConstants.tasksEndpoint,
      data: data,
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask({
    required UpsertTaskParams upsertTaskParams,
  }) async {
    final data = {
      'content': upsertTaskParams.content,
      'description': upsertTaskParams.description,
      'priority': upsertTaskParams.priority,
    };

    data.removeWhere((key, value) => value == null);
    final response = await networkService.post(
      '${ApiConstants.tasksEndpoint}/${upsertTaskParams.id}',
      data: data,
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> completeTask(String id) async {
    await networkService.post('${ApiConstants.tasksEndpoint}/$id/close');
  }
}
