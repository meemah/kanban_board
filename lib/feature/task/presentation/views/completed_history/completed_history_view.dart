import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kanban_board/core/extensions/date_extension.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/error_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/loading_state_widget.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/completed_history_bloc/completed_history_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/completed_history/widget/completed_history_card.dart';

class CompletedHistoryView extends StatefulWidget {
  const CompletedHistoryView({super.key});

  @override
  State<CompletedHistoryView> createState() => _CompletedHistoryViewState();
}

class _CompletedHistoryViewState extends State<CompletedHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<CompletedHistoryBloc>().add(GetCompletedHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: "Completed History", showBackButton: false),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: BlocBuilder<CompletedHistoryBloc, CompletedHistoryState>(
            builder: (context, state) {
              if (state is CompletedHistoryLoading) {
                return LoadingStateWidget(message: "Loading Completed Tasks");
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
                if (state.completedTasks.isEmpty) {
                  return EmptyStateWidget();
                }
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<CompletedHistoryBloc>().add(
                      GetCompletedHistoryEvent(),
                    );
                  },
                  child: GroupedListView<TaskEntity, String>(
                    elements: state.completedTasks,
                    groupBy: (task) => task.createdAt.formatCompletedDate,
                    groupSeparatorBuilder: (String groupByValue) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        groupByValue,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    itemBuilder: (context, task) =>
                        CompletedHistoryCard(taskEntity: task),
                    itemComparator: (task1, task2) =>
                        task1.createdAt.compareTo(task2.createdAt),
                    useStickyGroupSeparators: true,
                    order: GroupedListOrder.DESC,
                  ),
                );
              }
              return Text(state.toString());
            },
          ),
        ),
      ),
    );
  }
}
