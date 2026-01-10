import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_snackbar.dart';
import 'package:kanban_board/core/widgets/app_textfield.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/usecases/tasks_usecase/upsert_task_usecase.dart';
import 'package:kanban_board/feature/task/presentation/bloc/upsert_task_bloc/upsert_task_bloc.dart';

class UpsertTaskView extends StatefulWidget {
  final TaskEntity? taskEntity;
  const UpsertTaskView({super.key, this.taskEntity});

  @override
  State<UpsertTaskView> createState() => _UpsertTaskViewState();
}

class _UpsertTaskViewState extends State<UpsertTaskView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpsertTaskBloc, UpsertTaskState>(
      listener: (context, state) {
        if (state is UpsertTaskSuccess) {
          AppSnackBar.show(
            context,
            message: "Task added",
            appSnackbarType: AppSnackbarType.success,
          );
        }
        if (state is UpsertTaskFailure) {
          AppSnackBar.show(
            context,
            message: state.errorMessage,
            appSnackbarType: AppSnackbarType.failed,
          );
        }
      },
      child: Scaffold(
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
              // Row(
              //   children: [
              //     Expanded(
              //       child: AppTextField(
              //         textFieldTitle: "Due Date",
              //         prefixIcon: Icon(Icons.calendar_month),
              //       ),
              //     ),
              //     Gap(10.w),
              //     Expanded(child: AppTextField(textFieldTitle: "Priority")),
              //   ],
              // ),
              // Gap(15.h),
              AppTextField(
                textFieldTitle: "Description",
                maxLines: 8,
                textEditingController: _descriptionController,
              ),
              const Spacer(),
              BlocBuilder<UpsertTaskBloc, UpsertTaskState>(
                builder: (context, state) {
                  return AppButton(
                    isLoading: state is UpsertTaskLoading,
                    title: "Create Task",
                    onTap: () => context.read<UpsertTaskBloc>().add(
                      UpsertTask(
                        UpsertTaskParams(
                          description: _titleController.text,
                          content: _descriptionController.text,
                          id: widget.taskEntity?.id,
                        ),
                      ),
                    ),
                    prefixIcon: Icon(Icons.save, color: Colors.white, size: 18),
                  );
                },
              ),
              Gap(10.h),
            ],
          ),
        ),
      ),
    );
  }
}
