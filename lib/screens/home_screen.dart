import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_demo/config/routes/route_location.dart';
import 'package:sqflite_demo/data/models/task.dart';
import 'package:sqflite_demo/providers/providers.dart';
import 'package:sqflite_demo/utils/utils.dart';
import 'package:sqflite_demo/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTasks = _completedTasks(taskState.tasks);
    final uncompletedTasks = _uncompletedTasks(taskState.tasks);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: 'Aug 13, 2023',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    Gap(10),
                    DisplayWhiteText(
                      text: 'My Todo List',
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: uncompletedTasks,
                    ),
                    const Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                      tasks: completedTasks,
                      isCompletedTasks: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () => context.push(RouteLocation.createTask),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DisplayWhiteText(text: 'Add New Task'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _completedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }

  List<Task> _uncompletedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
