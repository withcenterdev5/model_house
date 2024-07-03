import 'package:flutter/material.dart';

class SimpleSignUpScreen extends StatelessWidget {
  static const String routeName = "/SimpleSignIn";
  const SimpleSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('signup'),
      ),
    );
  }
}
