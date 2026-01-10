import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';

class LoadingStateWidget extends StatelessWidget {
  final String? message;

  const LoadingStateWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            Gap(12.h),
            Text(
              message ?? "Loading data..",
              style: AppTextstyle.bodyMedium(),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
