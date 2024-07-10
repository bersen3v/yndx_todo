part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class RegisteringServicesState extends HomePageState {}

final class TodosLoadedState extends HomePageState {
  final int view;
  final List<Task> tasks;
  TodosLoadedState({
    required this.view,
    required this.tasks,
  });
}
