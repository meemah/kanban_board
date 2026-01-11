import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/generated/l10n.dart';

class KanbanBoardCard extends StatelessWidget {
  final TaskEntity taskEntity;
  final VoidCallback? onMove;
  const KanbanBoardCard({super.key, required this.taskEntity, this.onMove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () =>
            context.pushNamed(AppRouteName.taskDetails, extra: taskEntity),
        child: AppCard(
          shadowAlpha: 0.04,
          radius: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      taskEntity.content,
                      style: AppTextStyle.captionSemibold(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (onMove != null) ...[
                      const Gap(4),
                      GestureDetector(
                        onTap: onMove,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.textGray,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                S.current.move,
                                style: AppTextStyle.captionSemibold(
                                  color: AppColors.white,
                                ),
                              ),
                              Gap(1.w),
                              Icon(
                                Icons.chevron_right,
                                color: AppColors.white,
                                size: 18.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (taskEntity.description != null &&
                    taskEntity.description!.isNotEmpty) ...[
                  Gap(4.h),
                  Text(
                    taskEntity.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.captionSemibold(
                      color: AppColors.textGray,
                    ),
                  ),
                ],
                Gap(2.h),
                Divider(color: AppColors.textGrayLight.withValues(alpha: 0.2)),
                Gap(2.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 16,
                      color: AppColors.textGray,
                    ),
                    const Gap(3),
                    Text(
                      DateFormat('MMM d').format(taskEntity.createdAt),
                      style: AppTextStyle.captionSemibold(
                        color: AppColors.textGray,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
