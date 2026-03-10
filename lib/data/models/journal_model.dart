import 'package:hive/hive.dart';

part 'journal_model.g.dart';

@HiveType(typeId: 0)
class JournalModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String date;

  @HiveField(2)
  final String ambienceTitle;

  @HiveField(3)
  final String mood;

  @HiveField(4)
  final String entry;

  JournalModel({
    required this.id,
    required this.date,
    required this.ambienceTitle,
    required this.mood,
    required this.entry,
  });
}
