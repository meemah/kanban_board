import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/core/theme/app_colors.dart';

class KanbanViewToggle extends StatelessWidget {
  final KanbanViewMode selectedMode;
  final ValueChanged<KanbanViewMode> onToggle;

  const KanbanViewToggle({
    super.key,
    required this.selectedMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderRadius: BorderRadius.circular(8),
      constraints: const BoxConstraints(minHeight: 30, minWidth: 40),
      selectedColor: AppColors.white,
      fillColor: AppColors.primary,
      color: AppColors.black,
      isSelected: [
        selectedMode == KanbanViewMode.board,
        selectedMode == KanbanViewMode.tab,
      ],
      onPressed: (index) {
        onToggle(index == 0 ? KanbanViewMode.board : KanbanViewMode.tab);
      },
      children: [
        Icons.view_kanban,
        Icons.view_list,
      ].map((icon) => Icon(icon, size: 16.sp)).toList(),
    );
  }
}

enum KanbanViewMode { board, tab }
