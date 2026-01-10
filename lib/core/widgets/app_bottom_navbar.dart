import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/widgets/app_scaffold.dart';
import 'package:kanban_board/generated/l10n.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primary,
        backgroundColor: AppColors.borderLight,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: S.current.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: S.current.history,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: S.current.settings,
          ),
        ],
      ),
    );
  }
}
