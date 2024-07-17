// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/services/local_database_service.dart';
import 'package:yndx_todo/core/services/network_database_servise.dart';

class TodoService {
  // Offline-first: работа без интернета возможна полноценно, при последующем
  //запуске дошлётся то, что не смогло уйти в предыдущей сессии из-за
  //ошибок/отсутствия сети

  //Для имитации работы на нескольких устройствах созданы методы analyzeConflicts,
  //syncDeletedTasks и loadAndConsumeData

  //analyzeConflicts сверяет содержимое локальной базы с удаленной. Элементы присутствующие
  //в локальной базе, но отсутствующие в удаленной, добавляются в удаленную.
  //Анологично и в обратную сторону

  //syncDeletedTasks срабатывает, если произошло добавление задачи в то время,
  //когда отсутствовал интернет. Когда появляется интернет,
  //syncDeletedTasks сравнивает последние значения с сервера с новыми значениями
  //на сервере и если пока отсутствовал интернет на сервере появились новые задачи,
  //то они добавятся и в локальное хранилище

  late List<Task> _tasks;
  List<Task> get tasks => _tasks;

  final NetworkDatabaseServise networkDb;
  final LocalDatabaseService localDb;
  final LocalDatabaseService localDeletedDd;
  final LocalDatabaseService localNetworkCopy;

  List<Task> union = [];
  List<Task> addToNetwork = [];
  List<Task> addToLocal = [];
  List<int> deletedTaskId = [];
  List<int> changedTaskId = [];

  TodoService({
    required this.localDb,
    required this.localDeletedDd,
    required this.localNetworkCopy,
    required this.networkDb,
  });

  Future<void> init() async {
    await networkDb.init();
    await localDb.init();
    await localDeletedDd.init();
    await localNetworkCopy.init();
    await loadAndConsumeData();
  }

  Future<void> addTask(Task task) async {
    await localDb.addTask(task);
    await networkDb.addTask(task);
    await loadAndConsumeData();
  }

  Future<void> deleteTask(Task task) async {
    await localDb.removeTask(task);
    final onServerDeleted = await networkDb.removeTask(task);
    if (!onServerDeleted) {
      await localDeletedDd.addTask(task);
    }
    await loadAndConsumeData();
  }

  Future<void> changeTask(Task task) async {
    task.changedAt = DateTime.now();
    await localDb.updateTask(task);
    await networkDb.updateTask(task);
    await loadAndConsumeData();
  }

  Future<void> loadAndConsumeData() async {
    await networkDb.loadData();

    await syncDeletedTasks();
    final networkTasks = (networkDb.tasks ?? []);
    final localTasks = localDb.tasks;

    await analyzeConflicts(localTasks, networkTasks);

    _tasks = union;
    await localDb.addAll(addToLocal);
    await networkDb.addAll(addToNetwork);
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

  Future<void> syncDeletedTasks() async {
    for (Task task in localDeletedDd.tasks) {
      final onServerDeleted = await networkDb.removeTask(task);
      if (onServerDeleted) {
        await localDeletedDd.removeTask(task);
      }
    }
    for (Task task in localDb.tasks) {
      final inOldNetwork = localNetworkCopy.tasks.any((e) => e.id == task.id);
      final inNewNetwork = networkDb.tasks?.any((e) => e.id == task.id);
      if (inOldNetwork == true && inNewNetwork == false) {
        deleteTask(task);
      }
    }
    await networkDb.loadData();
    await localNetworkCopy.removeAll();
    await localNetworkCopy.addAll(networkDb.tasks ?? []);
  }

  void clean() {
    union = [];
    addToNetwork = [];
    addToLocal = [];
  }
}
