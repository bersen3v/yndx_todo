import 'package:yndx_todo/core/data/local_data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger.dart';

class LocalDatabaseService {
  late LocalDataFetcher db;
  List<Task> get tasks => db.tasks();

  LocalDatabaseService({
    required this.db,
  });

  Future<void> init() async {
    await db.init();
  }

  Future<void> addTask(final Task task) async {
    if (tasks.any((e) => e.id == task.id)) {
      await db.addTask(task.copyWith());
    }
  }

  Future<void> removeTask(Task task) async {
    final taskToRemove = tasks.firstWhere((e) => e.id == task.id);
    await db.removeTask(taskToRemove);
  }

  Future<void> updateTask(Task task) async {
    try {
      await db.updateTask(task);
    } catch (e) {
      logger.e('$e, $task');
    }
  }

  Future<void> addAll(List<Task> tasksNew) async {
    if (tasksNew.isNotEmpty) {
      for (Task task in tasksNew) {
        await db.addTask(task);
      }
    }
  }

  Future<void> removeAll() async {
    if (tasks.isNotEmpty) {
      for (Task task in tasks) {
        await db.removeTask(task);
      }
    }
  }

  Future<void> closeDb() async {
    await db.closeDb();
  }
}
