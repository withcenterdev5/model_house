import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  static TodoService? _instance;
  static TodoService get instance => _instance ??= TodoService._();

  TodoService._();

  CollectionReference taskCol =
      FirebaseFirestore.instance.collection('todo-task');
  CollectionReference assignCol =
      FirebaseFirestore.instance.collection('todo-assign');
}
