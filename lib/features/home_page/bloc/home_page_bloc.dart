import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:yndx_todo/features/home_page/presentation/widgets%20/tasks.dart';

part 'home_page_bloc.freezed.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState.loading()) {
    on<HomePageEvent>((event, emit) {});
  }
}

@freezed
sealed class HomePageState with _$HomePageState {
  const factory HomePageState({
    required List<Tasks> todos,
  }) = MainState;

  const factory HomePageState.loading() = LoadingState;
  const factory HomePageState.error({required String message}) = ErrorState;
}

@freezed
sealed class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.load() = LoadEvent;
  const factory HomePageEvent.delete(int id) = DeleteEvent;
  const factory HomePageEvent.toggleDone(int id) = ToggleDoneEvent;
}
