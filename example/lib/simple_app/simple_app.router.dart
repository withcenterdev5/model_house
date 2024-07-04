import 'package:example/simple_app/screens/home/simple.home.screen.dart';
import 'package:example/simple_app/screens/menu/simple.menu.screen.dart';
import 'package:example/simple_app/screens/user/simple.sign_in.screen.dart';
import 'package:example/simple_app/screens/user/simple.sign_up.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final simpleRouter = GoRouter(
  navigatorKey: globalNavigatorKey,
  redirect: (context, state) {
    if (FirebaseAuth.instance.currentUser == null) {
      return SimpleSignInScreen.routeName;
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: SimpleHomeScreen.routeName,
      builder: (context, state) => const SimpleHomeScreen(),
    ),
    GoRoute(
      path: SimpleSignInScreen.routeName,
      builder: (context, state) => const SimpleSignInScreen(),
    ),
    GoRoute(
      path: SimpleMenuScreen.routeName,
      builder: (context, state) => const SimpleMenuScreen(),
    ),
    GoRoute(
      path: SimpleSignUpScreen.routeName,
      builder: (context, state) => const SimpleSignUpScreen(),
    ),
    GoRoute(
      path: UserProfileUpdateScreen.routeName,
      builder: (context, state) => Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
            listTileTheme: ListTileThemeData(
                shape: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.outline),
            )),
          ),
          child: const UserProfileUpdateScreen()),
    ),
  ],
);
