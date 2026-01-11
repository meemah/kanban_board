import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kanban_board/core/extensions/date_extension.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_scaffold.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/error_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/loading_state_widget.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/completed_history_bloc/completed_history_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/completed_history/widget/completed_history_card.dart';
import 'package:kanban_board/generated/l10n.dart';

class CompletedHistoryView extends StatelessWidget {
  const CompletedHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(
        title: S.current.completedHistory,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: BlocBuilder<CompletedHistoryBloc, CompletedHistoryState>(
            builder: (context, state) {
              if (state is CompletedHistoryLoading) {
                return LoadingStateWidget(
                  message: S.current.loadingCompletedTasks,
                );
              }
              if (state is CompletedHistoryFailure) {
                return ErrorStateWidget(
                  message: state.errorMessage,
                  onRetry: () => context.read<CompletedHistoryBloc>().add(
                    GetCompletedHistoryEvent(),
                  ),
                );
              }
              if (state is CompletedHistorySuccess) {
                final completedTasks = state.completedTasks
                    .where(
                      (item) =>
                          item != null && item.taskEntity.completedAt != null,
                    )
                    .map((item) => item!.taskEntity)
                    .toList();
                if (completedTasks.isEmpty) {
                  return EmptyStateWidget();
                }
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<CompletedHistoryBloc>().add(
                      GetCompletedHistoryEvent(),
                    );
                  },
                  child: GroupedListView<TaskEntity, String>(
                    elements: completedTasks,
                    groupBy: (task) => task.completedAt!.formatCompletedDate,
                    groupSeparatorBuilder: (String groupByValue) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        groupByValue,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    itemBuilder: (context, task) => CompletedHistoryCard(
                      taskEntity: task,
                      durationInSecs:
                          state.completedTasks
                              .firstWhere((item) => item?.taskId == task.id)
                              ?.totalSeconds ??
                          0,
                    ),
                    itemComparator: (task1, task2) =>
                        task1.completedAt!.compareTo(task2.completedAt!),
                    useStickyGroupSeparators: true,
                    order: GroupedListOrder.DESC,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
