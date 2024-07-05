import 'package:flutter/material.dart';
import 'package:model_house/house_test/house_test_helper.functions.dart';
import 'package:model_house/model_house.dart';

class HouseTestScreen extends StatefulWidget {
  static const String routeName = '/HouseTest';
  const HouseTestScreen({super.key});

  @override
  State<HouseTestScreen> createState() => _HouseTestScreenState();
}

class _HouseTestScreenState extends State<HouseTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('House Test'),
      ),
      body: AuthState(
        builder: (user) => user == null
            ? const Text('Sign in to test')
            : Column(
                children: [
                  Text('Signed in with uid: ${user.uid}'),
                  const Divider(),
                  const Text("To start house test, press the button below"),
                  ElevatedButton(
                    onPressed: () async {
                      // await User.fromUid('abc').updateOnAuthStateChange();
                    },
                    child: const Text('User Model Test'),
                  ),
                  ElevatedButton(
                    onPressed: testTaskCreate,
                    child: const Text('Task Create Test'),
                  ),
                ],
              ),
      ),
    );
  }

  void testTaskCreate() async {
    testStart('Task Create Test');

    final created = await Task.create(title: 'fisrt task');

    isTrue(created.title == 'fisrt task', 'title is not correct');

    testReport();
  }
}
