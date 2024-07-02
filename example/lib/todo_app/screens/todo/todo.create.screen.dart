import 'package:flutter/material.dart';

class TodoCreateScreen extends StatefulWidget {
  static const String routeName = '/TodoCreate';
  const TodoCreateScreen({super.key});

  @override
  State<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoCreate'),
      ),
      body: const Column(
        children: [
          Text("TodoCreate"),
        ],
      ),
    );
  }
}
