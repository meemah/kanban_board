import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:kanban_board/feature/task/presentation/views/task_detail/widget/task_timer_card_header.dart';
import 'package:kanban_board/generated/l10n.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TaskStopWatchCard extends StatefulWidget {
  final int initialSeconds;
  final bool isRunning;
  final VoidCallback? onPause;
  final VoidCallback? onPlay;

  const TaskStopWatchCard({
    super.key,
    required this.initialSeconds,
    required this.isRunning,
    this.onPause,
    this.onPlay,
  });

  @override
  State<TaskStopWatchCard> createState() => _TaskStopWatchCardState();
}

class _TaskStopWatchCardState extends State<TaskStopWatchCard> {
  late final StopWatchTimer _stopWatchTimer;
  late bool _isRunning;

  @override
  void initState() {
    super.initState();
    _isRunning = widget.isRunning;

    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

    _stopWatchTimer.setPresetTime(mSec: widget.initialSeconds * 1000);

    if (_isRunning) {
      _stopWatchTimer.onStartTimer();
    }
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isRunning) {
        _stopWatchTimer.onStopTimer();
        widget.onPause?.call();
        _isRunning = false;
      } else {
        _stopWatchTimer.onStartTimer();
        widget.onPlay?.call();
        _isRunning = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TaskTimerCardHeader(
              title: _isRunning ? S.of(context).running : S.current.paused,
              color: _isRunning ? AppColors.green : Colors.orange,
            ),
            StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snapshot) {
                final milliseconds = snapshot.data ?? 0;
                final displayTime = StopWatchTimer.getDisplayTime(
                  milliseconds,
                  hours: true,
                  minute: true,
                  second: true,
                  milliSecond: false,
                );
                return Text(
                  displayTime,
                  style: AppTextStyle.headingSemibold(
                    fontSize: 40,
                  ).copyWith(letterSpacing: 2),
                );
              },
            ),
            Gap(24.h),
            AppButton(
              backgroundColor: _isRunning
                  ? AppColors.green
                  : AppColors.textGrayDark,
              title: _isRunning ? S.current.pause : S.of(context).resume,
              onTap: _togglePlayPause,
              textColor: AppColors.white,
              prefixIcon: Icon(
                _isRunning ? Icons.pause : Icons.play_arrow,
                size: 24,
                color: AppColors.white,
              ),
            ),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
