import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_textfield.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              textEditingController: TextEditingController(),
              textFieldTitle: "Task Title",
              hintText: "What needs to be done?",
            ),
            Gap(15.h),
            Text(
              "Status",
              style: AppTextstyle.subtextSemibold(
                color: AppColors.textGrayDark,
                fontWeight: FontWeight.w900,
              ),
            ),
            Gap(2.h),
            Row(
              children: TaskStatus.values
                  .map(
                    (status) => Container(
                      margin: EdgeInsets.only(right: 10.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Text(
                        status.title,
                        style: AppTextstyle.captionSemibold(),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Gap(15.h),
            AppTextField(
              textEditingController: TextEditingController(),
              textFieldTitle: "Description",
              maxLines: 8,
            ),
            const Spacer(),
            AppButton(
              title: "Create Task",
              onTap: () => null,
              prefixIcon: Icon(Icons.save, color: Colors.white, size: 18),
            ),
            Gap(10.h),
          ],
        ),
      ),
    );
  }
}

enum TaskStatus {
  todo("To Do"),
  inprogess("In Progress"),
  completed("Completed");

  final String title;
  const TaskStatus(this.title);
}
