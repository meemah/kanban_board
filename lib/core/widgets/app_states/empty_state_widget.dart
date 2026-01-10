import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? message;

  const EmptyStateWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 50.sp, color: Colors.grey[400]),
          Gap(12.h),
          Text(
            message ?? "No data available",
            style: AppTextstyle.bodyMedium(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
