import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/extensions/int_extension.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/entities/task_timer.dart';
import 'package:kanban_board/generated/l10n.dart';

class CompletedHistoryCard extends StatelessWidget {
  final TaskTimerEntity taskTimerEntity;

  const CompletedHistoryCard({super.key, required this.taskTimerEntity});

  @override
  Widget build(BuildContext context) {
    TaskEntity taskEntity = taskTimerEntity.taskEntity;
    return GestureDetector(
      onTap: () =>
          context.pushNamed(AppRouteName.taskDetails, extra: taskEntity),
      child: Container(
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
                    color: AppColors.green.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    CupertinoIcons.check_mark,
                    color: AppColors.green,
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
                        style: AppTextStyle.captionSemibold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        (taskEntity.description ?? "").isNotEmpty
                            ? taskEntity.description!
                            : S.current.noDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.captionRegular(
                          color: AppColors.textGrayDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(5.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.textGray,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 12.sp, color: AppColors.white),
                      Gap(2.w),
                      Text(
                        taskTimerEntity.currentElapsedSeconds.formatDuration,
                        style: AppTextStyle.captionSemibold(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
