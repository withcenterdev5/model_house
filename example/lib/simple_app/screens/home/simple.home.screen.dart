import 'package:example/simple_app/screens/user/simple.sign_in.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';

class SimpleHomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const SimpleHomeScreen({super.key});

  @override
  State<SimpleHomeScreen> createState() => _SimpleHomeScreenState();
}

class _SimpleHomeScreenState extends State<SimpleHomeScreen> {
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
              i.signOut();
              context.go(SimpleSignInScreen.routeName);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
