import 'package:flutter/material.dart';
import 'package:model_house/user/user.dart';

class UserPublicProfileScreen extends StatelessWidget {
  static const String routeName = '/UserPublicProfile';
  const UserPublicProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            child: SizedBox(
              child: Icon(Icons.person),
            ),
          ),
          Text(user.displayName ?? ''),
        ],
      ),
    );
  }
}
