import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';

class KanbanBoardCard extends StatelessWidget {
  final TaskEntity taskEntity;
  const KanbanBoardCard({super.key, required this.taskEntity});

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
                Text(taskEntity.content, style: AppTextstyle.captionSemibold()),
                if (taskEntity.description != null &&
                    taskEntity.description!.isNotEmpty) ...[
                  Gap(4.h),
                  Text(
                    taskEntity.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextstyle.captionSemibold(
                      color: AppColors.textGray,
                    ),
                  ),
                ],
                Gap(2.h),
                Divider(color: AppColors.textGrayLight.withValues(alpha: 0.2)),
                Gap(2.h),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: AppColors.textGray),
                    const Gap(3),
                    Text(
                      "Oct 26",
                      style: AppTextstyle.captionSemibold(
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
