import 'package:flutter/material.dart';
import 'package:sqflite_demo/config/config.dart';
import 'package:sqflite_demo/screens/home_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
