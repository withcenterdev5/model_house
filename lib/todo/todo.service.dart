import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_house/model_house.dart';

/// To-do service
///
/// This service is the only service for the whole to-do feature.

class TodoService {
  static TodoService? _instance;
  static TodoService get instance => _instance ??= TodoService._();

  TodoService._();

  CollectionReference taskCol =
      FirebaseFirestore.instance.collection('todo-task');
  CollectionReference assignCol =
      FirebaseFirestore.instance.collection('todo-assign');

  ///
  Future<List<Assign>> getAssigns(String taskId) async {
    final snapshot = await assignCol.where('taskId', isEqualTo: taskId).get();
    return snapshot.docs.map((e) => Assign.fromSnapshot(e)).toList();
  }
}
