import 'package:flutter/material.dart';

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
        title: const Text('ModelHouse'),
      ),
      body: const Column(
        children: [
          Text("ModelHouse"),
        ],
      ),
    );
  }
}
