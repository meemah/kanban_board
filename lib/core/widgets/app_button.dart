import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.title,
    this.prefixIcon,
    required this.onTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (height ?? 40).h,
        width: (width ?? double.infinity).w,
        decoration: BoxDecoration(
          color: (backgroundColor ?? AppColors.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null) ...[prefixIcon!, Gap(3.w)],
                    Text(
                      title,
                      style: AppTextStyle.bodySemibold(
                        color: textColor ?? AppColors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
