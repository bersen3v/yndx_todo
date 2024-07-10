import 'package:yndx_todo/core/data/data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';

class NetworkDatabaseServise {
  final MyHttpClient client;
  List<Task>? _tasks;

  NetworkDatabaseServise({required this.client});
  List<Task>? get tasks => _tasks;

  Future<void> init() async {
    final newTasks = await client.get();
    if (newTasks != null) _tasks = newTasks;
  }

  Future<void> loadData() async {
    _tasks = await client.get();
  }

  Future<void> addAll(List<Task> tasks) async {
    for (Task task in tasks) {
      await client.post(task);
    }
  }

  Future<void> addTask(Task task) async {
    await client.post(task);
  }

  Future<bool> updateTask(Task task) async {
    final answer = await client.put(task) == null ? false : true;
    return answer;
  }

  Future<void> removeAll() async {
    for (Task task in _tasks ?? []) {
      await client.delete(task);
    }
  }

  Future<bool> removeTask(Task task) async {
    final answer = await client.delete(task) == null ? false : true;
    await loadData();
    return answer;
  }
}
