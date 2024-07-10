import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yndx_todo/core/services/new_task_service.dart';
import 'package:yndx_todo/core/services/todo_service.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';

class DIContainer {
  final _todoService = TodoService();
  final _newTaskService = NewTaskService();

  Widget diProvider(BuildContext context, {required Widget child}) {
    return BlocProvider(
      create: (context) => HomePageBloc(_todoService),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => _newTaskService),
        ],
        child: child,
      ),
    );
  }
}
