import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';
import 'package:kanban_board/feature/task/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:kanban_board/generated/l10n.dart';

class TaskCommentList extends StatelessWidget {
  const TaskCommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.comments,
              style: AppTextStyle.captionMedium(color: AppColors.textGray),
            ),
            const Gap(3),
            if (state is GetCommentsSuccess) ...[
              if (state.comments.isEmpty) ...[
                Text(
                  S.current.noCommentsYet,
                  style: AppTextStyle.subtextRegular(color: AppColors.textDark),
                ),
              ] else ...[
                ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.comments.length,
                  separatorBuilder: (context, index) => Gap(10.h),
                  itemBuilder: (ctx, index) {
                    CommentEntity commentEntity = state.comments[index];
                    return Opacity(
                      opacity: commentEntity.isPending ? 0.5 : 1,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.person, size: 14),
                          ),
                          Gap(10),
                          Expanded(
                            child: Text(
                              commentEntity.content,
                              maxLines: 3,
                              style: AppTextStyle.captionSemibold(
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ],
        );
      },
    );
  }
}
