import 'package:equatable/equatable.dart';

class UpsertTaskParams extends Equatable {
  final String? id;
  final String content;
  final String? description;
  final int priority;

  const UpsertTaskParams({
    this.id,
    required this.content,
    this.description,
    this.priority = 1,
  });

  @override
  List<Object?> get props => [id, content, description, priority];
}
