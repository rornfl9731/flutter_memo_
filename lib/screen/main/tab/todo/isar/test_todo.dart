import 'package:isar/isar.dart';

part 'test_todo.g.dart';

@collection
class TodoIsar{
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String title;

}