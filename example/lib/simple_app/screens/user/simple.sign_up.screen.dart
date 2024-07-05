import 'package:example/simple_app/screens/home/simple.home.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';

class SimpleSignUpScreen extends StatefulWidget {
  static const String routeName = "/SimpleSignUpScreen";
  const SimpleSignUpScreen({super.key});

  @override
  State<SimpleSignUpScreen> createState() => _SimpleSignUpScreenState();
}

class _SimpleSignUpScreenState extends State<SimpleSignUpScreen> {
  final displayNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('signup'),
      ),
      body: Column(
        children: [
          LabelField(label: 'First name', controller: displayNameController),
          LabelField(label: 'Last name', controller: firstNameController),
          LabelField(label: 'Display name', controller: lastNameController),
          ElevatedButton(
              onPressed: () {

                my?.update(displayName: displayNameController.text,name: '${firstNameController.text} ${lastNameController.text}',);
                context.go(SimpleHomeScreen.routeName);
              },
              child: const Text('Done'))
        ],
      ),
    );
  }
}
