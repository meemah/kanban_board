import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/core/theme/font_family.dart';
import 'package:kanban_board/core/util/navigation/app_router.dart';

import "core/util/di/injection_container.dart" as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final apiToken = dotenv.env['TODOIST_API_TOKEN'] ?? '';
  if (apiToken.isEmpty) {
    throw Exception('TODOIST_API_TOKEN not found');
  }

  await di.init(apiToken: apiToken);
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
        return MaterialApp.router(
          title: 'Kanban Board',
          theme: ThemeData(fontFamily: FontFamily.worksans.value),
          routerConfig: appRouter,
        );
      },
    );
  }
}
