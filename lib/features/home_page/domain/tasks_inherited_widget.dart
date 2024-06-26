import 'package:flutter/material.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';

class Model extends ChangeNotifier {
  List<Task> tasks = [];
  List<Task> doneTasks = [];
  int completedTasks = 0;
  int allTasks = 0;

  void addTask(Task task) {
    tasks.add(task);
    allTasks++;
    notifyListeners();
  }

  void completeTask(Task task) {
    tasks.remove(task);
    doneTasks.add(task);
    completedTasks++;
    notifyListeners();
  }

  void deleteTask(Task task) {
    if (tasks.contains(task)) {
      tasks.remove(task);
      allTasks--;
      notifyListeners();
    }
  }

  void deleteDoneTask(Task task) {
    if (doneTasks.contains(task)) {
      doneTasks.remove(task);
      completedTasks--;
      allTasks--;
      notifyListeners();
    }
  }

  void taskUpdate(Task task) {
    if (tasks.contains(task)) {
      notifyListeners();
    }
  }
}

class TasksInheritedWidget extends InheritedNotifier<Model> {
  const TasksInheritedWidget(
      {required this.model, super.key, required this.child})
      : super(child: child, notifier: model);

  final Model model;
  final Widget child;

  static TasksInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksInheritedWidget>();
  }
}
