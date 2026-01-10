import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/add_coment_usecase.dart';
import 'package:kanban_board/feature/task/domain/usecases/comments_usecase/get_comments_usecase.dart';
import 'package:kanban_board/feature/task/presentation/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/widget/task_stopwatch_card.dart';
import 'package:kanban_board/generated/l10n.dart';

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
      GetCommentsEvent(params: GetCommentsParams(taskId: widget.task.id)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
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
                      context.read<TaskDetailBloc>().add(
                        AddCommentEvent(
                          addCommentParams: AddCommentParams(
                            taskId: widget.task.id,
                            content: _commentController.text.trim(),
                          ),
                        ),
                      );
                      _commentController.clear();
                    },
                    child: Icon(Icons.send, size: 16, color: Colors.white),
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
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                child: Text(
                  TaskStatus.inprogess.title.toUpperCase(),
                  style: AppTextStyle.captionSemibold(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ),
              Gap(10.h),
              Text(widget.task.content, style: AppTextStyle.headingBold()),
              Gap(30.h),
              TaskStopWatchCard(
                startDateTime: DateTime.now().subtract(
                  const Duration(minutes: 5, seconds: 30),
                ),
              ),
              Gap(30.h),
              Text(
                S.current.description,
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

              BlocBuilder<TaskDetailBloc, TaskDetailState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.current.comments,
                        style: AppTextStyle.captionMedium(
                          color: AppColors.textGray,
                        ),
                      ),
                      const Gap(3),
                      if (state is GetCommentsSuccess) ...[
                        if (state.comments.isEmpty) ...[
                          Text(
                            S.current.noCommentsYet,
                            style: AppTextStyle.subtextRegular(
                              color: AppColors.textDark,
                            ),
                          ),
                        ] else ...[
                          ListView.separated(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.comments.length,
                            separatorBuilder: (context, index) => Gap(10.h),
                            itemBuilder: (ctx, index) {
                              CommentEntity commentEntity =
                                  state.comments[index];
                              return Opacity(
                                opacity: commentEntity.isPending ? 0.5 : 1,
                                child: Row(
                                  children: [
                                    CircleAvatar(child: Icon(Icons.person)),
                                    Gap(10),
                                    Expanded(
                                      child: Text(
                                        commentEntity.content,
                                        maxLines: 3,
                                        style: AppTextStyle.subtextSemibold(
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
