import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class ToDo extends HiveObject{
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdDate;

  @HiveField(3)
  bool isSucceed;

  @HiveField(4)
  bool isBoxChecked;



  ToDo({required this.title, required this.content, required this.createdDate, this.isSucceed = false, this.isBoxChecked = false,});

}