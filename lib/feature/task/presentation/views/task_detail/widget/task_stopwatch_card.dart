import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_button.dart';
import 'package:kanban_board/core/widgets/app_card.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TaskStopWatchCard extends StatefulWidget {
  final DateTime startDateTime;
  final VoidCallback? onStop;

  const TaskStopWatchCard({
    super.key,
    required this.startDateTime,
    this.onStop,
  });

  @override
  State<TaskStopWatchCard> createState() => _TaskStopWatchCardState();
}

class _TaskStopWatchCardState extends State<TaskStopWatchCard> {
  late final StopWatchTimer _stopWatchTimer;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    final elapsed = DateTime.now()
        .difference(widget.startDateTime)
        .inMilliseconds;
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countUp,
      onEnded: () {
        setState(() {
          _isRunning = false;
        });
      },
    );

    _stopWatchTimer.setPresetTime(mSec: elapsed);
    _stopWatchTimer.onStartTimer();
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
        _isRunning = false;
      } else {
        _stopWatchTimer.onStartTimer();
        _isRunning = true;
      }
    });
  }

  void _stopTimer() {
    _stopWatchTimer.onStopTimer();
    setState(() {
      _isRunning = false;
    });

    widget.onStop?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, size: 16.sp, color: Colors.grey),
                    Gap(3.w),
                    Text('Total Time', style: AppTextStyle.captionSemibold()),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: _isRunning ? AppColors.primary : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isRunning ? 'RUNNING' : 'PAUSED',
                      style: AppTextStyle.captionSemibold(
                        color: _isRunning ? AppColors.primary : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(16.h),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppButton(
                    backgroundColor: AppColors.textGrayLight.withValues(
                      alpha: 0.2,
                    ),
                    title: _isRunning ? 'Pause' : 'Resume',
                    onTap: _togglePlayPause,
                    textColor: AppColors.textGrayLight,
                    prefixIcon: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      size: 24,
                      color: AppColors.textGrayLight,
                    ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: AppButton(
                    title: 'Stop',
                    onTap: _stopTimer,
                    prefixIcon: const Icon(
                      Icons.stop,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
