import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/feature/settings/presentation/language_cubit.dart';
import 'package:kanban_board/generated/l10n.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.current.language, style: AppTextStyle.subtextMedium()),
                  BlocBuilder<LanguageCubit, Locale>(
                    builder: (context, state) {
                      return DropdownButton<Locale>(
                        underline: const SizedBox.shrink(),
                        value: state,
                        items: S.delegate.supportedLocales
                            .map(
                              (entry) => DropdownMenuItem<Locale>(
                                value: entry,
                                child: Text(
                                  entry.languageCode,
                                  style: AppTextStyle.subtextMedium(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (locale) {
                          if (locale != null) {
                            context.read<LanguageCubit>().switchLocale(locale);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
