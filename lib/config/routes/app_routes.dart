import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_demo/config/routes/route_location.dart';
import 'package:sqflite_demo/screens/home_screen.dart';
import '../../screens/create_task_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
