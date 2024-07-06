import 'package:example/widget_app/widget_app.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:model_house/admin/admin.service.dart';
import 'package:model_house/model_house.dart';
import './firebase_options.dart';

/// main of the widget app
///
/// This app displays all the widgets of the Model House.
///
/// TODO: display more widgets of Model House
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TranslationService.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const UserApp());
}

class UserApp extends StatefulWidget {
  const UserApp({super.key});

  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  @override
  void initState() {
    super.initState();
    AdminService.instance.init();
    UserService.instance.init();
  }

  @override
  build(context) {
    return MaterialApp.router(
      theme: ThemeData(
        textTheme: const TextTheme(
          labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        ),
      ),
      routerConfig: widgetRouter,
    );
  }
}
