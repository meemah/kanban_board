import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/feature/task/presentation/views/add_task/add_task_view.dart';
import 'package:kanban_board/feature/task/presentation/views/completed_history/completed_history_view.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/kanban_board_view.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/task_details_view.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: AppRouteName.home,
      builder: (context, state) => const KanbanBoardView(),
    ),
    GoRoute(
      path: "/tasks/new",
      name: AppRouteName.taskCreate,
      builder: (context, state) => const AddTaskView(),
    ),
    GoRoute(
      path: "/tasks/completed",
      name: AppRouteName.taskCompletedHistory,
      builder: (context, state) => const CompletedHistoryView(),
    ),
    GoRoute(
      path: "/tasks/detail",
      name: AppRouteName.taskDetails,
      builder: (context, state) => const TaskDetailsView(),
    ),
  ],
);
