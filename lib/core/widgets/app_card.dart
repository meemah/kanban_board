import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/core/theme/app_colors.dart' show AppColors;

class AppCard extends StatelessWidget {
  final Widget child;
  final double? radius;
  final double? shadowAlpha;
  const AppCard({
    super.key,
    required this.child,
    this.radius,
    this.shadowAlpha,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: AppColors.black.withValues(alpha: (shadowAlpha ?? 0.03)),
          ),
        ],
        borderRadius: BorderRadius.circular((radius ?? 8).r),
      ),
      child: child,
    );
  }
}
