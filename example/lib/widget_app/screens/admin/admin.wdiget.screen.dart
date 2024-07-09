import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class AdminWidgetScreen extends StatefulWidget {
  static const String routeName = '/AdminWidget';
  const AdminWidgetScreen({super.key});

  @override
  State<AdminWidgetScreen> createState() => _AdminWidgetScreenState();
}

class _AdminWidgetScreenState extends State<AdminWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminWidget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "In this screen, all the widgets that are related to the Admin will be displayed.",
            ),
            const Divider(),
            const Text('Admin; to know if the user is admin or not.'),
            Admin(builder: (isAdmin) {
              return Text('Am i admin?: $isAdmin');
            })
          ],
        ),
      ),
    );
  }
}
