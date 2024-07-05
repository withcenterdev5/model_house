import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserWidgetScreen extends StatefulWidget {
  static const String routeName = '/UserSignIn';
  const UserWidgetScreen({super.key});

  @override
  State<UserWidgetScreen> createState() => _UserWidgetScreenState();
}

class _UserWidgetScreenState extends State<UserWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User related widgets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('UserAvatar; border, radus, size'),
                UserAvatar(user: my!),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('UserListView'),
          Container(
            height: 200,
            color: Colors.grey.shade300,
            child: const UserListView(),
          ),
          const Text('UserPhotoListView'),
          const UserPhotoListView(),
        ],
      ),
    );
  }
}
