import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/generated/l10n.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 50, color: Colors.red[400]),
            Gap(12.h),
            Text(
              message,
              style: AppTextstyle.bodyMedium(),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              Gap(20.h),
              AppButton(title: S.current.retry, onTap: onRetry!),
            ],
          ],
        ),
      ),
    );
  }
}
