import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_bottom_navbar.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/views/completed_history/completed_history_view.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/kanban_board_view.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/task_details_view.dart';
import 'package:kanban_board/feature/task/presentation/views/upsert_task/upsert_task_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/",
              name: AppRouteName.home,
              builder: (context, state) => const KanbanBoardView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/tasks/completed",
              name: AppRouteName.taskCompletedHistory,
              builder: (context, state) => const CompletedHistoryView(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: "/tasks/upsert",
      name: AppRouteName.taskUpsert,
      builder: (context, state) {
        final task = state.extra as TaskEntity?;
        return UpsertTaskView(taskEntity: task);
      },
    ),
    GoRoute(
      path: "/tasks/detail",
      name: AppRouteName.taskDetails,
      builder: (context, state) {
        final task = state.extra as TaskEntity;
        return TaskDetailsView(task: task);
      },
    ),
  ],
);
