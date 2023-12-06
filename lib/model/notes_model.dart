import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(1)
  final String tile;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final int color;

  NotesModel({
    required this.tile,
    required this.description,
    required this.category,
    required this.date,
    required this.color,
  });
}
