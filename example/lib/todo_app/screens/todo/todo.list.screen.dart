import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  static const String routeName = '/TodoList';
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
      ),
      body: const Column(
        children: [
          Text("TodoList"),
        ],
      ),
    );
  }
}
