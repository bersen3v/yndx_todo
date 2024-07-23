import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:yndx_todo/core/logger.dart';

class LocalDataFetcher {
  final String boxname;
  late Box<Task> _tasks;

  LocalDataFetcher({required this.boxname});
  List<Task> tasks() {
    return _tasks.values.toList();
  }

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(TaskAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(ImportanceAdapter());
    _tasks = await Hive.openBox<Task>(boxname);
  }

  Future<void> addTask(final Task task) async {
    await _tasks.add(task.copyWith());
  }

  Future<void> removeTask(Task task) async {
    try {
      await task.delete();
    } catch (e) {
      
    }
  }

  Future<void> updateTask(Task task) async {
    await task.delete();
    await _tasks.add(task.copyWith());
  }

  Future<void> closeDb() async {
    _tasks.close();
  }
}
