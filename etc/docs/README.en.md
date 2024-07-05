# House Model


## Building as a core developer

- Create your own example app with `example/lib/main.[feature].dart`. Don't touch others app.



## Coding convention


### Singular form

Singular form is preferred for field names, function names, collection names, etc.



### Model class

Model class does
- serialization/deserialization
- basic crud of the model data
- helper functions of the entity itself. Not other entities of the same model.
- encapsulating the refs.

Service class does
- something that are related with the model.
- showing screens
- search & listing data
- initialization, listening, etc.


### Data listing

Use `FirestoreQueryBuilder` or `FirebaseDatabaseQueryBuilder`. Use query builder all the time.



## Documentation

There is no enlish version of documents. So, write all the document in the source code. The comment int source code will turn into dartdoc when it is deployed into pub.dev.


## Test


### Unit test

Do the unit test as Flutter does.

### Widget test


Do the widget test as Flutter does.


### House test


This is a special test for house only. This is because it's not easy to test while connection with Firebase.



## Translation

- initialize

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.setDeviceLocale();
  runApp(const MyApp());
}
```

- t
```dart
Translation.instance.setLocale('ko');
'name'.t // 결과: 이름
```


- tr

```dart
final translationTexts = {
    'apple': {
        'en': {
            'zero': '{name} has no apple.',
            'one': '{name} has one apple.',
            'many': '{name} has {n} apples.',
        }
    }
};
```

Exmaple

```dart
TranslationService.instance.set(
  key: 'apple',
  locale: 'en',
  value: {
    'zero': '{name} has no apple.',
    'one': '{name} has one apple.',
    'many': '{name} has {n} apples.',
  },
);

int n = 0;
expect('apple'.tr(args: {'name': 'J'}, form: n), 'J has no apple.');
n = 1;
expect('apple'.tr(args: {'name': 'J'}, form: n), 'J has one apple.');
n = 3;
expect('apple'.tr(args: {'name': 'J', 'n': n}, form: n), 'J has 3 apples.');
```


## TODO feature


- A task can not be shared to multiple users. It's not sharing. It's like the same task is given to muliple user.
  - `Sharing task and working together is not supported, yet`.
  - When the creator creates a task, there will be only 1 copy of the task under `/todo-task`.

- The creator can assign the task to other user.
  - The list of assigns will be saved under `/todo-task/task-assign` subcollection.

- The relation of creator and assignee is N:M.








- flow of task.
```
creator -> assigned -> in-progress(working) -> [ finished | quit ] -> review -> [ accept | reject ]
```

- creator can schedule the task.

```
accept -> archive
```

```
reject -> [ask for enhance | failure | re-assign | delete]
```

```
failure -> [re-assign | achive | delete]
```


- status of task
```
[] -> [finished | quit] -> [accept | reject ]
```

- when the moderator accepts; properties: comment, score,
- when the moderator rejects; properties: comment, ... the task can be re-assigned to someone else.


'uid-1': { status: "", beginDate: "2024-07-04", endDate: "2024-08-01", comment: ".....", ......  }, 1M limit
status is is empty
date: is ongoing





///   'uid-2': {status: 'rejected', },
///   'uid-3': 'review',
///   'uid-4': 'ongoing',
///   'uid-5': 'done',


task1 { assigned: { .... }}
task2 { assigned: { .... }}
task3 { assigned: { .... : my-uid: finished }}
task4 { assigned: { .... }}
task5 { assigned: { .... }}
task6 { assigned: { .... }}
task7 { 
    task-aissgned /
        uid-1 { ... }
        uid-2 { ... }
        uid-3 { ... }
        uid-4 { ... }
}
/users/privte/"task-assigned"/ ... documents ...
/todo/people/works/tomorrow/"task_assgned"/ ... many documetns ...
...










