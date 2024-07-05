import 'package:model_house/house_test/house_test_helper.functions.dart';
import 'package:model_house/model_house.dart';

Future<Task> createTask() async {
  return await Task.get(
    (await Task.create(title: 'task - ${DateTime.now()}')).id,
  ) as Task;
}

void testTodo() async {
  testStart('Task CRUD Test');

  /// Task crud
  await testTaskCreate();
  await testTaskUpdate();

  /// Assign crud
  await testTaskAssign();
  await testTaskDeleteWithoutAssign();
  await testTaskDeleteWithAssign();
  await testTaskDeleteComplicated();

  /// Change the status;
  ///
  await testTaskStatus();

  await testReport();
}

Future testTaskAssign() async {
  final task = await createTask();
  final createdRef = await Assign.create(taskId: task.id, uid: my!.uid);
  final createdAssign = await Assign.get(createdRef.id) as Assign;
  isTrue(createdAssign.taskId == task.id, 'Task id is not correct');
  isTrue(createdAssign.uid == my!.uid, 'User id is not correct');

  final updatedTask = await Task.get(task.id) as Task;

  isTrue(
    updatedTask.assignTo.contains(my!.uid),
    'Expect: success on task assign',
  );
}

Future testTaskCreate() async {
  final ref = await Task.create(title: 'fisrt task');
  final created = await Task.get(ref.id) as Task;
  isTrue(created.title == 'fisrt task', 'title is not correct');
}

Future testTaskUpdate() async {
  final String title = 'task - ${DateTime.now()}';
  final ref = await Task.create(title: title);
  final created = await Task.get(ref.id) as Task;
  isTrue(created.title == title, 'title is not correct');

  await created.update(title: 'new title');
  final updated = await Task.get(ref.id) as Task;
  isTrue(updated.title == 'new title', 'Expect: success on title update.');
}

Future testTaskDeleteWithoutAssign() async {
  final ref = await Task.create(title: 'task - ${DateTime.now()}');
  final created = await Task.get(ref.id) as Task;

  await created.delete();
  final deleted = await Task.get(ref.id);
  isTrue(deleted == null, 'Expect: success on task delete.');
}

Future testTaskDeleteWithAssign() async {
  final ref = await Task.create(title: 'task - ${DateTime.now()}');
  final created = await Task.get(ref.id) as Task;

  final assignRef = await Assign.create(taskId: created.id, uid: my!.uid);

  await created.delete();
  final deleted = await Task.get(ref.id);
  isTrue(deleted == null, 'Expect: success on task delete.');

  final deletedAssign = await Assign.get(assignRef.id);
  isTrue(deletedAssign == null, 'Expect: success on assign delete.');
}

/// Complicated Test
///
///
Future testTaskDeleteComplicated() async {
  /// Create 2 tasks
  final taskA = await createTask();
  final taskB = await createTask();

  /// assign taskA to 3 users
  await Assign.create(taskId: taskA.id, uid: my!.uid);
  await Assign.create(taskId: taskA.id, uid: 'abc');
  await Assign.create(taskId: taskA.id, uid: 'def');

  /// assign taskB to 2 users
  await Assign.create(taskId: taskB.id, uid: '1');
  await Assign.create(taskId: taskB.id, uid: '2');

  /// Check if taskA has 3 assigns
  final List<Assign> assigns1 = await TodoService.instance.getAssigns(taskA.id);
  isTrue(assigns1.length == 3, 'Expect: success on assign create.');

  /// Delete taskA
  await taskA.delete();

  /// Check if taskA has 0 assigns
  final List<Assign> assigns1AfterDelete =
      await TodoService.instance.getAssigns(taskA.id);
  isTrue(assigns1AfterDelete.isEmpty, 'Expect: success on assign delete.');

  /// Check if taskB is not affected.
  final List<Assign> assigns2 = await TodoService.instance.getAssigns(taskB.id);
  isTrue(assigns2.length == 2, 'Expect: success on assign create.');
}

Future testTaskStatus() async {
  final a = await loginAsA();
  final b = await loginAsB();

  final task = await createTask();
  final assignCreatedRef = Assign.create(uid: a.uid, taskId: task.id) as Assign;

  final assign = await Assign.get(assignCreatedRef.id) as Assign;
  await assign.changeStatus(AssignStatus.progress);

  final updatedAssign = await Assign.get(task.id) as Assign;
  isTrue(updatedAssign.status == AssignStatus.progress,
      'Expect: success on task status change.');

  await loginAsA();
  await assign.changeStatus(AssignStatus.finished);
  final updatedAssign2 = await Assign.get(task.id) as Assign;
  isTrue(updatedAssign2.status == AssignStatus.finished,
      'Expect: success on task status change.');
}
