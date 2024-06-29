import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/services/new_task_service.dart';
import 'package:yndx_todo/core/services/todo_service.dart';
import 'package:yndx_todo/features/home_page/presentation/home.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final TodoService _todoService;
  int view = 0;

  HomePageBloc(this._todoService) : super(RegisteringServicesState()) {
    on<RegisterServicesEvent>(_onRegisterServicesEvent);
    on<AddTaskEvent>(_onAddTaskEvent);
    on<ChangeTaskEvent>(_onChangeTaskEvent);
    on<RemoveTaskEvent>(_onRemoveTaskEvent);
    on<ToggleScreenEvent>(_onToggleScreenEvent);
  }

  void _onToggleScreenEvent(
      ToggleScreenEvent event, Emitter<HomePageState> emit) {
    logger.d('toggle screen');
    emit(RegisteringServicesState());
    view = view == 0 ? 1 : 0;
    emit(TodosLoadedState(view: view, tasks: _todoService.tasks));
  }

  void _onRemoveTaskEvent(
      RemoveTaskEvent event, Emitter<HomePageState> emit) async {
    logger.d('remove task ${event.task.id}');
    Navigator.push(event.context,
        MaterialPageRoute(builder: (context) => const HomeScreen()));
    await _todoService.deleteTask(event.task);
    emit(TodosLoadedState(view: 0, tasks: _todoService.tasks));
    RepositoryProvider.of<NewTaskService>(event.context).resetTask();
  }

  void _onChangeTaskEvent(
      ChangeTaskEvent event, Emitter<HomePageState> emit) async {
    if (event.task.text != null && event.task.text != null) {
      logger.d('change task ${event.task.id}');
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      await _todoService.changeTask(event.task);
      emit(TodosLoadedState(view: 0, tasks: _todoService.tasks));
      RepositoryProvider.of<NewTaskService>(event.context).resetTask();
    }
  }

  void _onRegisterServicesEvent(
      RegisterServicesEvent event, Emitter<HomePageState> emit) async {
    logger.d('registering services');
    await _todoService.init();
    emit(TodosLoadedState(view: 0, tasks: _todoService.tasks));
  }

// importance: importance,
//         deadline: deadline,
//         changedAt: changedAt,
//         createdAt: createdAt,
//         done: done,
//         text: text,
//         id: id,
//         lastUpdatedBy: lastUpdatedBy);

  void _onAddTaskEvent(AddTaskEvent event, Emitter<HomePageState> emit) async {
    if (event.task.text != null && event.task.text != null) {
      Navigator.push(event.context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));

      event.task
        ..changedAt = DateTime.now()
        ..createdAt = DateTime.now()
        ..done = false
        ..id = DateTime.now().millisecondsSinceEpoch
        ..lastUpdatedBy = 'ivan bersenev';

      await _todoService.addTask(event.task);
      emit(TodosLoadedState(view: 0, tasks: _todoService.tasks));
      RepositoryProvider.of<NewTaskService>(event.context).resetTask();
    }
  }
}
