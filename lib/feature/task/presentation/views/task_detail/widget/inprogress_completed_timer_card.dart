import 'package:flutter/material.dart';
import 'package:kanban_board/core/extensions/int_extension.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/widget/task_timer_card_header.dart';
import 'package:kanban_board/generated/l10n.dart';

class InprogressOrCompletedTimeCard extends StatelessWidget {
  final int seconds;
  final TaskStatus taskStatus;
  const InprogressOrCompletedTimeCard({
    super.key,
    required this.seconds,
    required this.taskStatus,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TaskTimerCardHeader(
              title: taskStatus.title,
              color: taskStatus == TaskStatus.completed
                  ? AppColors.green
                  : AppColors.amber,
            ),
            if (taskStatus == TaskStatus.completed) ...[
              Text(
                seconds.formatDuration,
                style: AppTextStyle.headingSemibold(fontSize: 36),
              ),
            ] else ...[
              Text(
                S.current.moveTicketToInprogressToStartTimer,
                style: AppTextStyle.headingSemibold(color: AppColors.amber),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
