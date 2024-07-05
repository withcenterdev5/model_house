import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_house/todo/todo.service.dart';

/// A task entity class of Todo feature
///
/// This class provides all the functionalities of the entity itself. If the
/// app needs a functionality that is not for the entity itself, it should be
/// served by [TodoService].
///
/// A task can be assigned to muliple users. To assign a task to a user, use
/// [assignTo] method.
class Task {
  final CollectionReference col = TodoService.instance.taskCol;
  DocumentReference get ref => col.doc(id);

  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> assignTo = [];

  Task({
    required this.id,
    required this.title,
    this.content = '',
    required this.createdAt,
    required this.updatedAt,
    this.assignTo = const [],
  });

  factory Task.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    return Task.fromJson(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  factory Task.fromJson(Map<String, dynamic> json, String id) {
    final Timestamp? createdAt = json['createdAt'];
    final Timestamp? updatedAt = json['updatedAt'];
    return Task(
      id: id,
      title: json['title'],
      content: json['content'] ?? '',
      createdAt: createdAt == null ? DateTime.now() : createdAt.toDate(),
      updatedAt: updatedAt == null ? DateTime.now() : updatedAt.toDate(),
      assignTo: List<String>.from(json['assignTo'] ?? []),
    );
  }

  /// Get a task by its id
  ///
  /// Example:
  /// ```dart
  /// return (await get(createdRef.id))!;
  /// ```

  static Future<Task?> get(String id) async {
    final snapshot = await TodoService.instance.taskCol.doc(id).get();
    if (!snapshot.exists) return null;
    return Task.fromSnapshot(snapshot);
  }

  /// Create a task
  static Future<DocumentReference> create({
    required String title,
    String? content,
  }) async {
    return await TodoService.instance.taskCol.add({
      'title': title,
      if (content != null) 'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update task
  ///
  /// NOTE: This cannot be used to nullify any field.
  Future<void> update({
    String? title,
    String? content,
  }) async {
    final data = <String, dynamic>{
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (title != null) data['title'] = title;
    if (content != null) data['content'] = content;

    await ref.update(data);
  }

  /// Delete task including all the related assigns and data.
  Future<void> delete() async {
    final assigns = await TodoService.instance.assignCol
        .where('taskId', isEqualTo: id)
        .get();

    // Delete the assigns under the task first
    final assignDeleteFutures =
        assigns.docs.map((assign) => assign.reference.delete());

    // Await for all the assign delete futures
    await Future.wait(assignDeleteFutures);

    // Delete the task if all the assigns are deleted
    await ref.delete();
  }
}
