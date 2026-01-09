import 'package:hive/hive.dart';
import 'package:kanban_board/core/local/box_provider.dart';

class HiveBoxProvider<T> implements BoxProvider<T> {
  @override
  Future<Box<T>> openBox(String name) {
    return Hive.openBox<T>(name);
  }
}
