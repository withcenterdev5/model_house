import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  static TaskService? _instance;
  static TaskService get instance => _instance ??= TaskService._();

  TaskService._();

  CollectionReference col = FirebaseFirestore.instance.collection('todo-task');
}
