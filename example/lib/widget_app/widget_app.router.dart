import 'package:example/widget_app/screens/home/widget.home.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_house/model_house.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final widgetRouter = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      path: WidgetHomeScreen.routeName,
      builder: (context, state) => const WidgetHomeScreen(),
    ),
    GoRoute(
      path: UserProfileUpdateScreen.routeName,
      builder: (context, state) => const UserProfileUpdateScreen(),
    ),
  ],
);
