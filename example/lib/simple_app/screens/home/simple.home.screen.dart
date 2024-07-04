import 'dart:async';

import 'package:example/simple_app/screens/user/simple.sign_in.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';
import 'package:model_house/user/screens/user.public_profile.screen.dart';

class SimpleHomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const SimpleHomeScreen({super.key});

  @override
  State<SimpleHomeScreen> createState() => _SimpleHomeScreenState();
}

class _SimpleHomeScreenState extends State<SimpleHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('house.name'.t),
      ),
      body: Column(
        children: [
          MyDoc(builder: (my) {
            if (my == null) return const Text('loading');
            return Text(my.uid);
          }),
          //
          ElevatedButton(
            onPressed: () {
              context.push(UserProfileUpdateScreen.routeName);
            },
            child: const Text('Edit Profile'),
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .push(UserPublicProfileScreen.routeName, extra: {'user': my});
            },
            child: const Text('Public Profile'),
          ),
          ElevatedButton(
            onPressed: () async {
              final re = await showDialog<bool?>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Are you sure?'),
                        content: const Text('Do you want to resign?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop(true);
                              },
                              child: const Text('Yes')),
                          TextButton(
                              onPressed: () {
                                context.pop(false);
                              },
                              child: const Text('No'))
                        ],
                      ));

              if (re == false) return;
              dog('$re');
              // user resign
            },
            child: const Text('Resign'),
          ),
          ElevatedButton(
            onPressed: () {
              i.signOut();
              context.push(SimpleSignInScreen.routeName);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
