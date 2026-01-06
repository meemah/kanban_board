import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';

class CompletedHistoryView extends StatelessWidget {
  const CompletedHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed Tasks")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Colors.black.withValues(alpha: 0.03),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8.r),
                ),
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
                          children: [
                            Text(
                              "work on my kanban assessement",
                              style: AppTextstyle.captionSemibold(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(2.h),
                            Text(
                              "Finished at 10:00pm",
                              style: AppTextstyle.captionRegular(
                                color: AppColors.textGrayDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
