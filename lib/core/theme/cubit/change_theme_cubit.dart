import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit()
      : super(
          const ChangeThemeState(
            brightness: Brightness.dark,
          ),
        );

  void changeThemeBrightness() {
    emit(
      ChangeThemeState(
        brightness: state.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }
}
