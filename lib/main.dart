import 'package:flutter/material.dart';
import 'package:hive_example/hive/hive_service.dart';
import 'package:hive_example/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init_hive();
  runApp(MaterialApp(home: HomeScreen()));
}
