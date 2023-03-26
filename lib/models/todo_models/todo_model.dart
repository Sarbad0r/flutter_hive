import 'package:hive/hive.dart';

part "todo_model.g.dart";

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? datetime;

  TodoModel({this.id, this.name, this.datetime});
}
