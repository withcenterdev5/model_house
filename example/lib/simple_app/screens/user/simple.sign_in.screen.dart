import 'package:example/simple_app/screens/home/simple.home.screen.dart';
import 'package:example/simple_app/screens/user/simple.sign_up.screen.dart';
import 'package:flutter/material.dart';
import 'package:model_house/widgets/auth/email_password_login.dart';
import 'package:go_router/go_router.dart';

class SimpleSignInScreen extends StatefulWidget {
  static const String routeName = '/SimpleSignIn';
  const SimpleSignInScreen({super.key});

  @override
  State<SimpleSignInScreen> createState() => _SimpleSignInScreenState();
}

class _SimpleSignInScreenState extends State<SimpleSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpleSignIn'),
      ),
      body: Column(
        children: [
          EmailPasswordLogin(
            onRegister: () {
              context.go(SimpleSignUpScreen.routeName);
            },
            onLogin: () {
              context.go(SimpleHomeScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
