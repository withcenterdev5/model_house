import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_house/todo/task.service.dart';

/// To-do entity class
///
/// This class provides all the functionalities of the entity itself. If the
/// app needs a functionality that is not for the entity itself, it should be
/// served by [TaskService].
///
class Task {
  final CollectionReference col = TaskService.instance.col;

  String id;
  String title;
  String? content;
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.content,
    required this.createdAt,
  });

  factory Task.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return Task.fromJson(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  factory Task.fromJson(Map<String, dynamic> json, String id) {
    return Task(
      id: id,
      title: json['title'],
      content: json['content'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  static Future<Task?> get(String id) async {
    final snapshot = await TaskService.instance.col.doc(id).get();
    if (snapshot.exists) {
      return Task.fromSnapshot(snapshot);
    }
    return null;
  }

  static Future<Task> create({
    required String title,
    String? content,
  }) async {
    final createdRef = await TaskService.instance.col.add({
      'title': title,
      if (content != null) 'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return (await get(createdRef.id))!;
  }

  update() {}

  delete() {}
}
