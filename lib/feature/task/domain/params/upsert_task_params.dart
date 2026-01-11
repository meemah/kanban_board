import 'package:equatable/equatable.dart';

class UpsertTaskParams extends Equatable {
  final String? id;
  final String content;
  final String? description;

  const UpsertTaskParams({this.id, required this.content, this.description});

  @override
  List<Object?> get props => [id, content, description];
}
