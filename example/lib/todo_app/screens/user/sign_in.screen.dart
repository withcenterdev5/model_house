import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/SignIn';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: const Column(
        children: [
          Text("SignIn"),
        ],
      ),
    );
  }
}
