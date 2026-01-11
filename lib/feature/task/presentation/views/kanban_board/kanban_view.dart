import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_scaffold.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/error_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/loading_state_widget.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_bloc/kanban_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_board_container.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_tab_container.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_view_toggle.dart';
import 'package:kanban_board/generated/l10n.dart';

class KanbanHomeView extends StatefulWidget {
  const KanbanHomeView({super.key});

  @override
  State<KanbanHomeView> createState() => _KanbanHomeViewState();
}

class _KanbanHomeViewState extends State<KanbanHomeView> {
  KanbanViewMode _viewMode = KanbanViewMode.tab;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KanbanBloc>().add(GetAllTaskEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(
        title: S.current.kanbanBoard,
        showBackButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: KanbanViewToggle(
              selectedMode: _viewMode,
              onToggle: (mode) {
                setState(() => _viewMode = mode);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () => context.pushNamed(AppRouteName.taskUpsert),
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: AppColors.black.withValues(alpha: 0.1),
              ),
            ],
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: BlocBuilder<KanbanBloc, KanbanState>(
            builder: (context, state) {
              if (state is KanbanLoading) {
                return LoadingStateWidget(
                  message: S.current.settingUpYourTasks,
                );
              }
              if (state is KanbanFailure) {
                return ErrorStateWidget(
                  message: state.errorMessage,
                  onRetry: () =>
                      context.read<KanbanBloc>().add(GetAllTaskEvent()),
                );
              }
              if (state is KanbanSuccess) {
                if (state.tasks.values.isEmpty) {
                  EmptyStateWidget(message: S.current.youHaveNoTaskYet);
                }
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<KanbanBloc>().add(GetAllTaskEvent()),
                  child: _viewMode == KanbanViewMode.tab
                      ? KanbanTabContainer()
                      : KanbanBoardContainer(),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
