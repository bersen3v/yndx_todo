import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/services/todo_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final TodoService todoService;
  int view = 0;

  HomePageBloc(this.todoService) : super(RegisteringServicesState()) {
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
    emit(TodosLoadedState(
      view: view,
      tasks: todoService.tasks,
    ));
  }

  void _onRemoveTaskEvent(
      RemoveTaskEvent event, Emitter<HomePageState> emit) async {
    emit(RegisteringServicesState());
    logger.d('remove task ${event.task.id}');
    event.context.go('/');
    await todoService.deleteTask(event.task);
    emit(TodosLoadedState(
      view: view,
      tasks: todoService.tasks,
    ));
  }

  void _onChangeTaskEvent(
      ChangeTaskEvent event, Emitter<HomePageState> emit) async {
    emit(RegisteringServicesState());
    logger.d('change task ${event.task.id}');
    await todoService.changeTask(event.task);
    emit(TodosLoadedState(
      view: view,
      tasks: todoService.tasks,
    ));
  }

  void _onRegisterServicesEvent(
      RegisterServicesEvent event, Emitter<HomePageState> emit) async {
    logger.d('registering services');
    emit(RegisteringServicesState());
    await todoService.init();
    emit(TodosLoadedState(
      view: view,
      tasks: todoService.tasks,
    ));
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
    emit(RegisteringServicesState());
    event.task
      ..changedAt = DateTime.now()
      ..createdAt = DateTime.now()
      ..done = false
      ..id = DateTime.now().millisecondsSinceEpoch
      ..lastUpdatedBy = 'ivan bersenev';

    await todoService.addTask(event.task);
    view = 0;
    emit(TodosLoadedState(
      view: view,
      tasks: todoService.tasks,
    ));
  }
}
