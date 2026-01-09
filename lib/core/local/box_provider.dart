import 'package:hive/hive.dart';

abstract class BoxProvider<T> {
  Future<Box<T>> openBox(String name);
}
