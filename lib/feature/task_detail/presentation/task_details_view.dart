import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/feature/add_task/presentation/add_task_view.dart';
import 'package:kanban_board/feature/task_detail/presentation/widget/task_stopwatch_card.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      bottomSheet: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,
                style: AppTextstyle.captionMedium(),
                decoration: InputDecoration(
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 20.w),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Icon(Icons.send, size: 16, color: Colors.white),
                  ),
                  border: InputBorder.none,
                  fillColor: AppColors.textGrayLight.withValues(alpha: 0.2),
                  filled: true,
                  hintText: "Add a comment..",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 8.h,
                  ).copyWith(bottom: 20.h),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        title: Text("Task Details"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.w),
            child: Icon(Icons.edit, color: AppColors.primary, size: 17.sp),
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
                  style: AppTextstyle.captionSemibold(
                    color: AppColors.primary,
                    fontSize: 10,
                  ),
                ),
              ),
              Gap(10.h),
              Text(
                "Work on kanban board assessment",
                style: AppTextstyle.headingBold(),
              ),
              Gap(30.h),
              TaskStopWatchCard(
                startDateTime: DateTime.now().subtract(
                  const Duration(minutes: 5, seconds: 30),
                ),
              ),
              Gap(30.h),
              Text(
                "DESCRIPTION",
                style: AppTextstyle.captionMedium(color: AppColors.textGray),
              ),
              const Gap(3),
              Text(
                "Hello, I am keeping Loreem ipsum here as a placeholder. Hello, I am keeping Loreem ipsum here as a placeholder. Hello, I am keeping Loreem ipsum here as a placeholder.Hello, I am keeping Loreem ipsum here as a placeholder",
                style: AppTextstyle.subtextRegular(
                  color: AppColors.textDark,
                ).copyWith(height: 1.5),
              ),
              Gap(30.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "COMMENTS",
                    style: AppTextstyle.captionMedium(
                      color: AppColors.textGray,
                    ),
                  ),
                  const Gap(3),
                  Row(
                    children: [
                      CircleAvatar(child: Icon(Icons.person)),
                      Gap(10),
                      Expanded(
                        child: Text(
                          "Hello, I am keeping Loreem ipsum here as a placeholder. Hello, I am keeping Loreem ipsum here as a placeholder. Hello, I am keeping Loreem ipsum here as a placeholder.Hello, I am keeping Loreem ipsum here as a placeholder",
                          maxLines: 3,
                          style: AppTextstyle.subtextRegular(
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
