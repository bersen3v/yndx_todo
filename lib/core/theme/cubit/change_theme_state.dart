part of 'change_theme_cubit.dart';

@immutable
class ChangeThemeState extends Equatable {
  final Brightness brightness;

  const ChangeThemeState({required this.brightness});

  @override
  List<Object?> get props => [brightness];
}
