import 'package:example/todo_app/todo_app.router.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: todoRouter,
    );
  }
}
