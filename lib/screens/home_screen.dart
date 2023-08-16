import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_demo/config/routes/route_location.dart';
import 'package:sqflite_demo/data/data.dart';
import 'package:sqflite_demo/utils/task_categories.dart';
import 'package:sqflite_demo/utils/utils.dart';
import 'package:sqflite_demo/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static HomeScreen builder(BuildContext context, GoRouterState state) =>
      const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

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
                    const DisplayListOfTasks(
                      tasks: [
                        Task(
                          title: 'title 1',
                          note: '',
                          time: '11:12',
                          date: 'Aug, 14',
                          category: TaskCategories.education,
                          isCompleted: false,
                        ),
                        Task(
                          title: 'title 2',
                          note: 'note',
                          time: '11:46',
                          date: 'Aug, 14',
                          category: TaskCategories.health,
                          isCompleted: false,
                        ),
                      ],
                    ),
                    const Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    const Gap(20),
                    const DisplayListOfTasks(
                      tasks: [
                        Task(
                          title: 'title 3',
                          note: '',
                          time: '11:54',
                          date: 'Aug, 14',
                          category: TaskCategories.others,
                          isCompleted: true,
                        ),
                        Task(
                          title: 'title 2',
                          note: 'note',
                          time: '11:55',
                          date: 'Aug, 14',
                          category: TaskCategories.personal,
                          isCompleted: true,
                        ),
                      ],
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
}
