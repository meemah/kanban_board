class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://api.todoist.com/rest/v2';
  static const String tasksEndpoint = '/tasks';
  static const String projectsEndpoint = '/projects';
  static const String commentsEndpoint = '/comments';

  static const String authHeader = 'Authorization';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
}
