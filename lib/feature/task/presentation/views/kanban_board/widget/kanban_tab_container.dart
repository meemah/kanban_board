import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_bloc/kanban_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_board_card.dart';
import 'package:kanban_board/generated/l10n.dart';

class KanbanTabContainer extends StatelessWidget {
  const KanbanTabContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanbanBloc, KanbanState>(
      builder: (context, state) {
        if (state is KanbanSuccess) {
          return DefaultTabController(
            length: TaskStatus.values.length,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.gray400.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.white,
                    unselectedLabelColor: AppColors.black,
                    labelStyle: AppTextStyle.subtextMedium(),
                    unselectedLabelStyle: AppTextStyle.subtextMedium(),

                    tabs: TaskStatus.values
                        .map((status) => Tab(text: status.title))
                        .toList(),
                    dividerColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: TaskStatus.values.map((status) {
                      final tasks = state.getTasksByStatus(status);
                      if (tasks.isEmpty) {
                        return EmptyStateWidget(
                          message: S.current.noTasksInStatus(status.title),
                        );
                      }
                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return KanbanBoardCard(
                            taskEntity: tasks[index],
                            onMove: status == TaskStatus.completed
                                ? null
                                : () {
                                    final currentIndex = TaskStatus.values
                                        .indexOf(status);

                                    if (currentIndex <
                                        TaskStatus.values.length - 1) {
                                      final newStatus =
                                          TaskStatus.values[currentIndex + 1];

                                      context.read<KanbanBloc>().add(
                                        MoveTaskEvent(
                                          task: tasks[index],
                                          oldStatus: status,
                                          newStatus: newStatus,
                                        ),
                                      );
                                    }
                                  },
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
