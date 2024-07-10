import 'package:hive/hive.dart';

part 'scores.g.dart';

@HiveType(typeId: 0)
class scores extends HiveObject {
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final int compScore;
  @HiveField(3)
  final int genScore;
  @HiveField(4)
  final int totalScore;
  @HiveField(5)
  final int wordPerMinute;

  scores(
      {required this.id,
      required this.username,
      required this.compScore,
      required this.genScore,
      required this.totalScore,
      required this.wordPerMinute});
}
