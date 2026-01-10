import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String textFieldTitle;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.textEditingController,
    required this.textFieldTitle,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldTitle,
          style: AppTextstyle.subtextSemibold(
            color: AppColors.textGrayDark,
            fontWeight: FontWeight.w900,
          ),
        ),
        Gap(2.h),
        TextFormField(
          controller: textEditingController,
          readOnly: readOnly,
          maxLines: maxLines,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          style: AppTextstyle.subtextSemibold(),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: maxLines > 1 ? 12.h : 0,
            ),
            prefixIcon: prefixIcon,
            hintStyle: AppTextstyle.subtextSemibold().copyWith(
              color: AppColors.textGrayLight,
            ),
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textGray, width: 2),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }
}
