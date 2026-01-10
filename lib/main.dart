import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/core/local/setup_hive.dart';
import 'package:kanban_board/core/theme/font_family.dart';
import 'package:kanban_board/core/util/navigation/app_router.dart';
import 'package:kanban_board/feature/settings/presentation/language_cubit.dart';
import 'package:kanban_board/feature/task/presentation/bloc/completed_history_bloc/completed_history_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_board_bloc/kanban_board_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:kanban_board/feature/task/presentation/bloc/upsert_task_bloc/upsert_task_bloc.dart';
import 'package:kanban_board/generated/l10n.dart';

import "core/util/di/injection_container.dart" as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final apiToken = dotenv.env['TODOIST_API_TOKEN'] ?? '';
  if (apiToken.isEmpty) {
    throw Exception('TODOIST_API_TOKEN not found');
  }

  await di.setupServiceLocator(apiToken: apiToken);
  await setupHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LanguageCubit()),
            BlocProvider(create: (_) => di.sl<UpsertTaskBloc>()),
            BlocProvider(create: (_) => di.sl<KanbanBoardBloc>()),
            BlocProvider(create: (_) => di.sl<CompletedHistoryBloc>()),
            BlocProvider(create: (_) => di.sl<TaskDetailBloc>()),
          ],
          child: BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'Kanban Board',
                theme: ThemeData(fontFamily: FontFamily.worksans.value),
                routerConfig: appRouter,
                locale: locale,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
