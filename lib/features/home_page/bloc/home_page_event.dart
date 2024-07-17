// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class RegisterServicesEvent extends HomePageEvent {}

class AddTaskEvent extends HomePageEvent {
  final Task task;
  final BuildContext context;

  AddTaskEvent({
    required this.task,
    required this.context,
  });
}

class ChangeTaskEvent extends HomePageEvent {
  final Task task;
  final BuildContext context;

  ChangeTaskEvent({
    required this.task,
    required this.context,
  });
}

class RemoveTaskEvent extends HomePageEvent {
  final Task task;
  final BuildContext context;

  RemoveTaskEvent({
    required this.task,
    required this.context,
  });
}

class ToggleScreenEvent extends HomePageEvent {
  ToggleScreenEvent();
}

class LoadTodosEvent extends HomePageEvent {}
