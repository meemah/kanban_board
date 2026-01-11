import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/generated/l10n.dart';

class TaskTimerCardHeader extends StatelessWidget {
  final String title;
  final Color color;
  const TaskTimerCardHeader({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, size: 14.sp, color: AppColors.textGrayDark),
              Gap(3.w),
              Text(S.current.totalTime, style: AppTextStyle.captionSemibold()),
            ],
          ),
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(title, style: AppTextStyle.captionSemibold(color: color)),
            ],
          ),
        ],
      ),
    );
  }
}
