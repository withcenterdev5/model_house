import 'package:example/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModelHouse'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HouseHomeScreen(),
            ),
            child: const Text("House with Friendship"),
          ),
          ElevatedButton(
            onPressed: () => showGeneralDialog(
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HouseHomeScreen(),
            ),
            child: const Text("House with Friendship, Chat"),
          ),
        ],
      ),
    );
  }
}
