import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:kanban_board/core/extensions/date_extension.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/completed_history_bloc/completed_history_bloc.dart';

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
                return CircularProgressIndicator();
              }
              if (state is CompletedHistoryFailure) {
                return Text("Opps Error Occured");
              }
              if (state is CompletedHistorySuccess) {
                if (state.data.isEmpty) {
                  return Text("You have no completed item");
                }
                return GroupedListView<TaskEntity, String>(
                  elements: state.data,
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

class CompletedHistoryCard extends StatelessWidget {
  final TaskEntity taskEntity;
  const CompletedHistoryCard({super.key, required this.taskEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: AppCard(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: AppColors.primary,
                  size: 16,
                ),
              ),
              Gap(5.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      taskEntity.content,
                      style: AppTextstyle.captionSemibold(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (taskEntity.description != null) ...[
                      Gap(2.h),
                      Text(
                        taskEntity.description ?? "No description",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextstyle.captionRegular(
                          color: AppColors.textGrayDark,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Gap(5.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.textGrayLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      size: 12.sp,
                      color: AppColors.textGrayLight,
                    ),
                    Text(
                      "1hr 20m",
                      style: AppTextstyle.captionSemibold(
                        color: AppColors.textGrayLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
