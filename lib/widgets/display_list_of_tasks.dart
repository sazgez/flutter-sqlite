import 'package:flutter/material.dart';
import 'package:sqflite_demo/utils/extensions.dart';
import '../data/models/task.dart';
import 'common_container.dart';

class DisplayListOfTasks extends StatelessWidget {
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksMessage = isCompletedTasks
        ? 'There is no completed task yet.'
        : 'There is no task to do!';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return const Text('Home');
              },
            ),
    );
  }
}
