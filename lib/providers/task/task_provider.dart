import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_demo/data/data.dart';
import 'package:sqflite_demo/providers/providers.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>(
  (ref) {
    final repository = ref.watch(taskRepositoryProvider);
    return TaskNotifier(repository);
  },
);
