import 'package:cloud_firestore/cloud_firestore.dart';

/// To-do entity class
///
/// This class provides all the functionalities of the entity itself. If the
/// app needs a functionality that is not for the entity itself, it should be
/// served by [TaskService].
///
class Task {
  final CollectionReference col =
      FirebaseFirestore.instance.collection('todo-tasks');

  String? title;
  bool completed;

  Task({
    this.title,
    this.completed = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        completed = json['completed'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
      };

  create() {}

  update() {}

  delete() {}
}
