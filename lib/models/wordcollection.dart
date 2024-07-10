import 'package:hive/hive.dart';

part 'wordcollection.g.dart';

@HiveType(typeId: 2)
class WordCollection {
  @HiveField(0, defaultValue: 0)
  int? id;
  @HiveField(1)
  String username;
  @HiveField(2)
  List<String> wordcollected;
  @HiveField(3)
  DateTime date;

  WordCollection(
      {required this.username,
      required this.wordcollected,
      required this.date});
}
