import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/features/add_task_page/presentation/add_task_page.dart';
import 'package:yndx_todo/features/home_page/presentation/home.dart';

GoRouter router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    return null;
  },
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/addtask',
      builder: (context, state) {
        Task? task = state.extra is Task ? state.extra as Task : null;
        return AddTaskScreen(
          task: task,
        );
      },
    ),
  ],
);
