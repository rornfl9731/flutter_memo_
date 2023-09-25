import 'package:hive/hive.dart';

part 'memo.g.dart';

@HiveType(typeId: 0)
class Memo extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdDate;

  @HiveField(3)
  bool isFavorite;

  Memo({required this.title, required this.content, required this.createdDate, this.isFavorite = false});

}