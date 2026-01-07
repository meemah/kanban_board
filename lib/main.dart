import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban_board/core/theme/font_family.dart';
import 'package:kanban_board/feature/add_task/presentation/add_task_view.dart';

void main() {
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
        return MaterialApp(
          title: 'Kanban Board',
          theme: ThemeData(fontFamily: FontFamily.worksans.value),
          home: AddTaskView(),
        );
      },
    );
  }
}
