import 'package:get_it/get_it.dart';
import 'package:kanban_board/core/network_service/network_service.dart';

final serviceLocator = GetIt.I;

Future<void> init({required String apiToken}) async {
  serviceLocator.registerLazySingleton(
    () => NetworkService(apiToken: apiToken),
  );
}
