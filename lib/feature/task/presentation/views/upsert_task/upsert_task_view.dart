import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/widgets/app_bar.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_scaffold.dart';
import 'package:kanban_board/core/widgets/app_snackbar.dart';
import 'package:kanban_board/core/widgets/app_textfield.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/domain/params/upsert_task_params.dart'
    show UpsertTaskParams;
import 'package:kanban_board/feature/task/presentation/bloc/upsert_task_bloc/upsert_task_bloc.dart';
import 'package:kanban_board/generated/l10n.dart';

class UpsertTaskView extends StatefulWidget {
  final TaskEntity? taskEntity;
  const UpsertTaskView({super.key, this.taskEntity});

  @override
  State<UpsertTaskView> createState() => _UpsertTaskViewState();
}

class _UpsertTaskViewState extends State<UpsertTaskView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.taskEntity != null) {
      _titleController.text = widget.taskEntity!.content;
      _descriptionController.text = widget.taskEntity!.description ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.taskEntity != null;
    return BlocListener<UpsertTaskBloc, UpsertTaskState>(
      listener: (context, state) {
        if (state is UpsertTaskSuccess) {
          AppSnackBar.show(
            context,
            message: S.current.taskAction(
              isEditing ? S.current.updated : S.current.added,
            ),
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
      child: AppScaffold(
        appBar: CustomAppBar(
          title: S.current.upsertTaskPageTitle(
            isEditing ? S.current.update : S.current.add,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  textEditingController: _titleController,
                  textFieldTitle: S.current.taskTitle,
                  hintText: S.current.whatNeedsToBeDone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.current.taskTitleIsRequired;
                    }
                    return null;
                  },
                ),
                Gap(15.h),
                AppTextField(
                  textFieldTitle: S.current.description,
                  maxLines: 8,
                  textEditingController: _descriptionController,
                ),
                const Spacer(),
                BlocBuilder<UpsertTaskBloc, UpsertTaskState>(
                  builder: (context, state) {
                    return AppButton(
                      isLoading: state is UpsertTaskLoading,
                      title: S.current.upsertTaskPageTitle(
                        isEditing ? S.current.update : S.current.add,
                      ),
                      onTap: () {
                        if (!_formKey.currentState!.validate()) return;
                        context.read<UpsertTaskBloc>().add(
                          UpsertTask(
                            UpsertTaskParams(
                              description: _descriptionController.text,
                              content: _titleController.text,
                              id: widget.taskEntity?.id,
                            ),
                          ),
                        );
                      },
                      prefixIcon: Icon(
                        Icons.save,
                        color: AppColors.white,
                        size: 18,
                      ),
                    );
                  },
                ),
                Gap(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
