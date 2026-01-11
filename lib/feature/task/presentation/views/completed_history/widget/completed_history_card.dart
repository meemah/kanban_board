import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/extensions/int_extension.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/generated/l10n.dart';

class CompletedHistoryCard extends StatelessWidget {
  final TaskEntity taskEntity;
  final int durationInSecs;
  const CompletedHistoryCard({
    super.key,
    required this.taskEntity,
    required this.durationInSecs,
  });

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
                      durationInSecs.formatDuration,
                      style: AppTextStyle.captionSemibold(
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
