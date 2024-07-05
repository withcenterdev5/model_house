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
        title: const Text('UserSignIn'),
      ),
      body: Column(
        children: [
          UserAvatar(user: my!),
          SizedBox(
            height: 72,
            child: UserListView(
              scrollDirection: Axis.horizontal,
              itemBuilder: (user, index) => Padding(
                padding: EdgeInsets.fromLTRB(index == 0 ? 24 : 8, 8, 8, 8),
                child: SizedBox(
                  width: 72 - 16,
                  child: UserAvatar(user: user),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
