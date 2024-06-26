import 'package:flutter/material.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';

class NewTaskInheritedWidget extends InheritedWidget {
  const NewTaskInheritedWidget(
      {required this.task, super.key, required this.child})
      : super(child: child);

  final Widget child;
  final Task task;

  static NewTaskInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NewTaskInheritedWidget>();
  }

  @override
  bool updateShouldNotify(NewTaskInheritedWidget oldWidget) {
    return true;
  }
}
