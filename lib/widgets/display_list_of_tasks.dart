import 'package:flutter/material.dart';
import 'package:sqflite_demo/providers/providers.dart';
import 'package:sqflite_demo/utils/app_alerts.dart';
import 'package:sqflite_demo/utils/extensions.dart';
import 'package:sqflite_demo/widgets/task_details.dart';
import 'package:sqflite_demo/widgets/task_tile.dart';
import '../data/models/task.dart';
import 'common_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          : ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showDeleteAlertDialog(
                      context,
                      ref,
                      task,
                    );
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return TaskDetails(task: task);
                      },
                    );
                  },
                  child: TaskTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(taskProvider.notifier)
                          .updateTask(task)
                          .then(
                        (value) {
                          AppAlerts.displaySnackBar(
                            context,
                            task.isCompleted
                                ? 'Task uncompleted'
                                : 'Task completed',
                          );
                        },
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
