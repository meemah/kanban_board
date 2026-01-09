import 'package:kanban_board/core/network_service/api_constants.dart';
import 'package:kanban_board/core/network_service/network_service.dart';

import '../models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> createTask({
    required String content,
    String? description,
    int priority = 1,
    List<String>? labels,
  });
  Future<TaskModel> updateTask(String id, Map<String, dynamic> updates);
  Future<void> deleteTask(String id);
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
    required String content,
    String? description,
    int priority = 1,
    List<String>? labels,
  }) async {
    final data = {
      'content': content,
      if (description != null) 'description': description,
      'priority': priority,
      if (labels != null && labels.isNotEmpty) 'labels': labels,
    };

    final response = await networkService.post(
      ApiConstants.tasksEndpoint,
      data: data,
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<TaskModel> updateTask(String id, Map<String, dynamic> updates) async {
    final response = await networkService.post(
      '${ApiConstants.tasksEndpoint}/$id',
      data: updates,
    );
    return TaskModel.fromJson(response.data);
  }

  @override
  Future<void> deleteTask(String id) async {
    await networkService.delete('${ApiConstants.tasksEndpoint}/$id');
  }

  @override
  Future<void> completeTask(String id) async {
    await networkService.post('${ApiConstants.tasksEndpoint}/$id/close');
  }
}
