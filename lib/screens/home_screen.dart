import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/hive/hive_service.dart';
import 'package:hive_example/models/todo_models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive example"),
      ),
      body: Column(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                itemCount: HiveService.todoList().length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController controller =
                                TextEditingController(
                                    text: HiveService.todoList()[index].name ??
                                        '');
                            return AlertDialog(
                              title: const Text("Add"),
                              content: TextField(controller: controller),
                              actions: [
                                ElevatedButton(
                                    onPressed: () => setState(() {
                                          HiveService.todoList()[index].name =
                                              controller.text;

                                          HiveService.updateTodo(index,
                                              HiveService.todoList()[index]);
                                          Navigator.pop(context);
                                        }),
                                    child: Text("Save"))
                              ],
                            );
                          }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${HiveService.todoList()[index].name}"),
                          IconButton(
                              onPressed: () => setState(() {
                                    HiveService.deleteTodo(index);
                                  }),
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    )),
          ),
          TextButton(
              onPressed: () => setState(() {
                    HiveService.deleteAll();
                  }),
              child: Text("Clear all"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) {
                TextEditingController controller =
                    TextEditingController(text: '');
                return AlertDialog(
                  title: const Text("Add"),
                  content: TextField(controller: controller),
                  actions: [
                    ElevatedButton(
                        onPressed: () => setState(() {
                              HiveService.add_todo(TodoModel(
                                  id: rendomNumI(),
                                  name: controller.text,
                                  datetime: DateTime.now()
                                      .toString()
                                      .substring(0, 19)));
                              Navigator.pop(context);
                            }),
                        child: Text("Save"))
                  ],
                );
              }),
          child: Icon(Icons.save)),
    );
  }

  int rendomNumI() {
    Random rnd = Random();
    return rnd.nextInt(100);
  }
}
