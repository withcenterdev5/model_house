import 'package:cloud_firestore/cloud_firestore.dart';

/// To-do model class
///
///
///
class Todo {
  final CollectionReference col =
      FirebaseFirestore.instance.collection('todos');

  String? title;
  bool completed;

  Todo({
    this.title,
    this.completed = false,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
      };
}
