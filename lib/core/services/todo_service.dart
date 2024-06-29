import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/services/local_database_service.dart';
import 'package:yndx_todo/core/services/network_database_servise.dart';

class TodoService {
  late List<Task> _tasks;
  List<Task> get tasks => _tasks;

  final _networkDb = NetworkDatabaseServise();
  final _localDb = LocalDatabaseService(boxname: 'tasks');
  final _localDeletedDd = LocalDatabaseService(boxname: 'deletedTasks');
  final _localNetworkCopy = LocalDatabaseService(boxname: 'localnetworkcopy');

  List<Task> union = [];
  List<Task> addToNetwork = [];
  List<Task> addToLocal = [];
  List<int> deletedTaskId = [];
  List<int> changedTaskId = [];

  Future<void> init() async {
    await _networkDb.init();
    await _localDb.init();
    await _localDeletedDd.init();
    await _localNetworkCopy.init();
    // print(_networkDb.tasks);
    // print(_localDb.tasks);
    // print(_localDeletedDd.tasks);
    // print(_localNetworkCopy.tasks);
    await loadAndConsumeData();
  }

  Future<void> addTask(Task task) async {
    await _localDb.addTask(task);
    await _networkDb.addTask(task);
    await loadAndConsumeData();
  }

  Future<void> deleteTask(Task task) async {
    await _localDb.removeTask(task);
    final onServerDeleted = await _networkDb.removeTask(task);
    if (!onServerDeleted) {
      await _localDeletedDd.addTask(task);
    }
    await loadAndConsumeData();
  }

  Future<void> syncDeletedTasks() async {
    // print('networkcopy =====> ${_localNetworkCopy.tasks}');
    // print('network =====> ${_networkDb.tasks}');

    for (Task task in _localDeletedDd.tasks) {
      final onServerDeleted = await _networkDb.removeTask(task);
      if (onServerDeleted) {
        await _localDeletedDd.removeTask(task);
      }
    }
    for (Task task in _localDb.tasks) {
      final inOldNetwork = _localNetworkCopy.tasks.any((e) => e.id == task.id);
      final inNewNetwork = _networkDb.tasks?.any((e) => e.id == task.id);
      if (inOldNetwork == true && inNewNetwork == false) {
        deleteTask(task);
      }
    }
    await _networkDb.loadData();
    await _localNetworkCopy.removeAll();
    await _localNetworkCopy.addAll(_networkDb.tasks ?? []);
    // print('lnc');
    // print(_localNetworkCopy.tasks);
  }

  Future<void> changeTask(Task task) async {
    task.changedAt = DateTime.now();
    await _localDb.updateTask(task);
    await _networkDb.updateTask(task);
    await loadAndConsumeData();
  }

  Future<void> loadAndConsumeData() async {
    await _networkDb.loadData();

    await syncDeletedTasks();
    final networkTasks = (_networkDb.tasks ?? []);
    final localTasks = _localDb.tasks;

    // print('NETWORK ======> ${_networkDb.tasks}');
    // print('LOCAL ======> ${_localDb.tasks}');

    await analyzeConflicts(localTasks, networkTasks);

    _tasks = union;
    await _localDb.addAll(addToLocal);
    await _networkDb.addAll(addToNetwork);
    clean();
  }

  Future<void> analyzeConflicts(List<Task> local, List<Task> network) async {
    Map<int, Task> taskMap = {};
    Set<int> localId = {};
    Set<int> networkId = {};

    for (Task task in local) {
      if (!taskMap.containsKey(task.id) ||
          (taskMap[task.id]?.changedAt ?? DateTime.now())
              .isBefore(task.changedAt!)) {
        taskMap[task.id!] = task;
      }
      localId.add(task.id!);
    }
    for (Task task in network) {
      if (!taskMap.containsKey(task.id) ||
          (taskMap[task.id]?.changedAt ?? DateTime.now())
              .isBefore(task.changedAt!)) {
        taskMap[task.id!] = task;
      }
      networkId.add(task.id!);
    }
    union = taskMap.values.toList();
    addToLocal = networkId.difference(localId).map((e) => taskMap[e]!).toList();
    addToNetwork =
        localId.difference(networkId).map((e) => taskMap[e]!).toList();
  }

  void clean() {
    union = [];
    addToNetwork = [];
    addToLocal = [];
  }
}
