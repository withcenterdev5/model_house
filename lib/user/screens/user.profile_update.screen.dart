import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserProfileUpdateScreen extends StatefulWidget {
  static const String routeName = '/UserProfileUpdate';
  const UserProfileUpdateScreen({super.key});

  @override
  State<UserProfileUpdateScreen> createState() =>
      _UserProfileUpdateScreenState();
}

class _UserProfileUpdateScreenState extends State<UserProfileUpdateScreen> {
  final displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    displayNameController.text = my?.displayName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Column(
        children: [
          LabelField(label: 'displayName'.t, controller: displayNameController),
          ElevatedButton(
            onPressed: () {
              my?.update(
                displayName: displayNameController.text,
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
