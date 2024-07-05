import 'package:model_house/house_test/house_test_helper.functions.dart';
import 'package:model_house/model_house.dart';

Future<Task> createTask() async {
  return await Task.get(
    (await Task.create(title: 'task - ${DateTime.now()}')).id,
  ) as Task;
}

void testTaskCrud() {
  testStart('Task CRUD Test');
  testTaskCreate();
  testTaskUpdate();
  testReport();
}

void testTaskAssign() async {
  testStart('Task Assign Test');

  final task = await createTask();
  final createdRef = await Assign.create(taskId: task.id, uid: my!.uid);
  final createdAssign = await Assign.get(createdRef.id) as Assign;
  isTrue(createdAssign.taskId == task.id, 'Task id is not correct');
  isTrue(createdAssign.uid == my!.uid, 'User id is not correct');
  testReport();
}

void testTaskCreate() async {
  final ref = await Task.create(title: 'fisrt task');
  final created = await Task.get(ref.id) as Task;
  isTrue(created.title == 'fisrt task', 'title is not correct');
}

void testTaskUpdate() async {
  final String title = 'task - ${DateTime.now()}';
  final ref = await Task.create(title: title);
  final created = await Task.get(ref.id) as Task;
  isTrue(created.title == title, 'title is not correct');

  await created.update(title: 'new title');
  final updated = await Task.get(ref.id) as Task;
  isTrue(updated.title == 'new title', 'Expect: success on title update.');
}
