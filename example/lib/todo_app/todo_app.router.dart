import 'package:example/todo_app/screens/home/todo.home.screen.dart';
import 'package:example/todo_app/screens/todo/todo.list.screen.dart';
import 'package:example/todo_app/screens/user/sign_in.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final todoRouter = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      path: TodoHomeScreen.routeName,
      builder: (context, state) => const TodoHomeScreen(),
    ),
    GoRoute(
      path: TodoListScreen.routeName,
      builder: (context, state) => const TodoListScreen(),
    ),
    GoRoute(
      path: SignInScreen.routeName,
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
