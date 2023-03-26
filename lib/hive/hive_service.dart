// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/models/todo_models/todo_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';

class HiveService {
  static init_hive() async {
    if (!kIsWeb) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      await Directory('${appDocDir.path}/db.hive').create(recursive: true);

      /// Initiate Hive database
      Hive.init("${appDocDir.path}/db.hive");
    } else {
      Hive.init("db.hive");
    }

    Hive.registerAdapter(TodoModelAdapter());

    await Hive.openBox<TodoModel>('todo_list');
  }

  static void add_todo(TodoModel todoModel) {
    Hive.box<TodoModel>('todo_list').add(todoModel);
    print('added');
  }

  static List<TodoModel> todoList() {
    return Hive.box<TodoModel>('todo_list').values.toList();
  }

  static void deleteTodo(int index) {
    Hive.box<TodoModel>("todo_list").deleteAt(index);
  }

  static void updateTodo(int index, TodoModel todoModel) {
    Hive.box<TodoModel>('todo_list').putAt(index, todoModel);
  }

  static void deleteAll() {
    Hive.box<TodoModel>("todo_list").clear();
  }
}
