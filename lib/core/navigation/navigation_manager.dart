import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger.dart';

class NavigationManager {
  static void goToMainScreen(BuildContext context) {
    context.go('/');
    logger.d('goToMainScreen');
  }

  static void goToAddTaskScreen(BuildContext context, [Task? task]) {
    context.go('/addtask', extra: task);
    logger.d('goToAddTaskScreen with extra: $task');
  }
}
