import 'package:example/simple_app/screens/user/simple.sign_in.screen.dart';
import 'package:flutter/material.dart';
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
          //
          iam.signedIn
              ? const Text('Yes, sign in !!')
              : const Text('Not signed In'),
          AuthStateChanges(
            builder: (user) => user == null
                ? const SimpleSignInScreen()
                : Column(
                    children: [
                      Text(user.uid),
                      DisplayName(
                        uid: user.uid,
                        initialData: user.displayName,
                      ),
                      ElevatedButton(
                        onPressed: () => i.signOut(),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
