import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserPublicProfileScreen extends StatelessWidget {
  static const String routeName = '/UserPublicProfile';
  const UserPublicProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            UserAvatar(
              user: user,
              size: 100,
              radius: 50,
            ),
            Text(
              user.displayName,
            ),
            Text(
              user.name,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Like',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
