import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class HouseHomeScreen extends StatefulWidget {
  static const String routeName = '/ModelHouse';
  const HouseHomeScreen({super.key});

  @override
  State<HouseHomeScreen> createState() => _HouseHomeScreenState();
}

class _HouseHomeScreenState extends State<HouseHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('house.name'.t),
      ),
      body: Column(
        children: [
          iam.signedIn
              ? const Text('Yes, sign in !!')
              : const Text('Not signed In'),
        ],
      ),
    );
  }
}
