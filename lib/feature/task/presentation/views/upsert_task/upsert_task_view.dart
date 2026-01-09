import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_textfield.dart';

class UpsertTaskView extends StatefulWidget {
  const UpsertTaskView({super.key});

  @override
  State<UpsertTaskView> createState() => _UpsertTaskViewState();
}

class _UpsertTaskViewState extends State<UpsertTaskView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: CustomAppBar(title: "Add Task"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              textEditingController: _titleController,
              textFieldTitle: "Task Title",
              hintText: "What needs to be done?",
            ),
            Gap(15.h),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    textFieldTitle: "Due Date",
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                ),
                Gap(10.w),
                Expanded(child: AppTextField(textFieldTitle: "Priority")),
              ],
            ),
            Gap(15.h),
            AppTextField(
              textFieldTitle: "Description",
              maxLines: 8,
              textEditingController: _descriptionController,
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
