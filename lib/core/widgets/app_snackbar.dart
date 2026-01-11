import 'package:flutter/material.dart';
import 'package:kanban_board/core/theme/app_colors.dart';

enum AppSnackbarType {
  failed(AppColors.red),
  success(AppColors.green),
  info(AppColors.amber);

  final Color color;
  const AppSnackbarType(this.color);
}

class AppSnackBar {
  const AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
    required AppSnackbarType appSnackbarType,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),

        duration: duration,
        action: action,
        backgroundColor: appSnackbarType.color,
      ),
    );
  }
}
