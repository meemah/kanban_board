import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_scaffold.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/params/add_comment_params.dart';
import 'package:kanban_board/feature/task/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/widget/task_comments_list.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/widget/task_stopwatch_card.dart';
import 'package:kanban_board/generated/l10n.dart';

import 'widget/inprogress_completed_timer_card.dart';

class TaskDetailsView extends StatefulWidget {
  final TaskEntity task;
  const TaskDetailsView({super.key, required this.task});

  @override
  State<TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskDetailBloc>().add(
      InitializeTaskDetailEvent(task: widget.task),
    );
    context.read<CommentBloc>().add(GetCommentsEvent(taskId: widget.task.id));
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _commentController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 1,
              maxLines: 5,
              style: AppTextStyle.captionMedium(),
              decoration: InputDecoration(
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 20.w),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (_commentController.text.trim().isEmpty) {
                        return;
                      }
                      context.read<CommentBloc>().add(
                        AddCommentEvent(
                          addCommentParams: AddCommentParams(
                            taskId: widget.task.id,
                            content: _commentController.text.trim(),
                          ),
                        ),
                      );
                      _commentController.clear();
                    },
                    child: Icon(Icons.send, size: 16, color: AppColors.white),
                  ),
                ),
                border: InputBorder.none,
                fillColor: AppColors.textGrayLight.withValues(alpha: 0.2),
                filled: true,
                hintText: S.current.addAComment,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 8.h,
                ).copyWith(bottom: 20.h),
              ),
            ),
          ),
        ],
      ),
      appBar: CustomAppBar(
        title: S.current.taskDetails,
        actions: [
          GestureDetector(
            onTap: () =>
                context.pushNamed(AppRouteName.taskUpsert, extra: widget.task),
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Icon(Icons.edit, color: AppColors.primary, size: 20.sp),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskDetailTimer(task: widget.task),
              Gap(30.h),
              Text(
                S.current.description.toUpperCase(),
                style: AppTextStyle.captionMedium(color: AppColors.textGray),
              ),
              const Gap(3),
              Text(
                widget.task.description == null ||
                        widget.task.description!.isEmpty
                    ? "N/A"
                    : widget.task.description!,
                style: AppTextStyle.subtextRegular(
                  color: AppColors.textDark,
                ).copyWith(height: 1.5),
              ),
              Gap(30.h),
              TaskCommentList(),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskDetailTimer extends StatelessWidget {
  final TaskEntity task;
  const TaskDetailTimer({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        if (state is! TaskDetailLoaded) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
              child: Text(
                state.status.title.toUpperCase(),
                style: AppTextStyle.captionSemibold(
                  color: AppColors.primary,
                  fontSize: 10,
                ),
              ),
            ),
            Gap(10.h),
            Text(task.content, style: AppTextStyle.headingBold()),
            Gap(30.h),
            if (state.status == TaskStatus.inProgress &&
                state.timer != null) ...[
              TaskStopWatchCard(
                initialSeconds: state.timer!.currentElapsedSeconds,
                isRunning: state.timer!.isRunning,
                onPause: () =>
                    context.read<TaskDetailBloc>().add(PauseTaskTimerEvent()),
                onPlay: () =>
                    context.read<TaskDetailBloc>().add(ResumeTaskTimerEvent()),
              ),
            ] else ...[
              InprogressOrCompletedTimeCard(
                seconds: state.timer?.currentElapsedSeconds ?? 0,
                taskStatus: state.status,
              ),
            ],
          ],
        );
      },
    );
  }
}
