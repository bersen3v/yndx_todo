import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:path/path.dart';
import 'package:yndx_todo/core/logger.dart';

class LocalDatabaseService {
  final String boxname;
  late Box<Task> _tasks;

  LocalDatabaseService({required this.boxname});
  List<Task> get tasks => _tasks.values.toList();

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(TaskAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(ImportanceAdapter());
    _tasks = await Hive.openBox<Task>(boxname);
  }

  Future<void> addTask(final Task task) async {
    if (!tasks.any((e) => e.id == task.id)) {
      await _tasks.add(task.copyWith());
    }
  }

  Future<void> removeTask(Task task) async {
    final taskToRemove = tasks.firstWhere((e) => e.id == task.id);
    await taskToRemove.delete();
  }

  Future<void> updateTask(Task task) async {
    try {
      final taskToEdit = _tasks.values.firstWhere((e) => e.id == task.id);
      final index = taskToEdit.key as int;
      await _tasks.put(index, task);
    } catch (e) {}
  }

  Future<void> addAll(List<Task> tasksNew) async {
    if (tasksNew.isNotEmpty) {
      for (Task task in tasksNew) {
        await addTask(task);
      }
    }
  }

  Future<void> removeAll() async {
    if (tasks.isNotEmpty) {
      for (Task task in tasks) {
        await removeTask(task);
      }
    }
  }

  Future<void> closeDb() async {
    _tasks.close();
  }
}
