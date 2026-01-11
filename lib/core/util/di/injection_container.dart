import 'package:get_it/get_it.dart';
import 'package:kanban_board/core/network_service/network_service.dart';
import 'package:kanban_board/feature/task/data/datasource/comment_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/datasource/task_remote_datasource.dart';
import 'package:kanban_board/feature/task/data/datasource/timer_local_datasource.dart';
import 'package:kanban_board/feature/task/data/repository/comment_repository_impl/comment_repository_impl.dart';
import 'package:kanban_board/feature/task/data/repository/task_repository_impl/task_repository_impl.dart';
import 'package:kanban_board/feature/task/data/repository/timer_repository_impl/timer_repository_impl.dart';
import 'package:kanban_board/feature/task/domain/repositories/comment_repository.dart';
import 'package:kanban_board/feature/task/domain/repositories/task_repository.dart';
import 'package:kanban_board/feature/task/domain/repositories/timer_repository.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_completed_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_task_status_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/get_tasks_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/move_task_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/upsert_task_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/get_task_timer_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/pause_timer_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/timer_usecase/resume_timer_usecase.dart';
import 'package:kanban_board/feature/task/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/completed_history_bloc/completed_history_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_board_bloc/kanban_board_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/upsert_task_bloc/upsert_task_bloc.dart';

final sl = GetIt.I;

Future<void> setupServiceLocator({required String apiToken}) async {
  sl.registerLazySingleton(() => NetworkService(apiToken: apiToken));

  sl.registerFactory(() => CommentBloc(sl(), sl()));
  sl.registerFactory(() => TaskDetailBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => UpsertTaskBloc(sl()));
  sl.registerFactory(() => KanbanBoardBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CompletedHistoryBloc(sl()));

  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TimerRepository>(() => TimerRepositoryImpl(sl()));

  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(networkService: sl()),
  );

  sl.registerLazySingleton<CommentRemoteDataSource>(
    () => CommentRemoteDatasourceImpl(networkService: sl()),
  );

  sl.registerLazySingleton<TimerLocalDatasource>(
    () => TimerLocalDatasourceImpl(),
  );

  sl.registerLazySingleton(() => AddComentUsecase(sl()));

  sl.registerLazySingleton(() => GetCommentsUsecase(commentRepository: sl()));

  sl.registerLazySingleton(() => GetActiveTasksUsecase(sl()));

  sl.registerLazySingleton(
    () => MoveTaskUseCase(taskRepo: sl(), timerRepo: sl()),
  );
  sl.registerLazySingleton(() => UpsertTaskUseCase(sl()));

  sl.registerLazySingleton(() => GetTaskStatusUsecase(sl()));

  sl.registerLazySingleton(() => GetCompletedTasksUsecase(sl()));

  sl.registerLazySingleton(() => ResumeTimerUseCase(timerRepo: sl()));
  sl.registerLazySingleton(() => GetTaskTimerUsecase(timerRepo: sl()));
  sl.registerLazySingleton(() => PauseTimerUseCase(sl()));
}
