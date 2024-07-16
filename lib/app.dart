import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yndx_todo/core/di.dart';
import 'package:yndx_todo/core/enums/evvironment.dart';
import 'package:yndx_todo/core/navigation/router.dart';
import 'package:yndx_todo/core/theme/cubit/change_theme_cubit.dart';
import 'package:yndx_todo/core/theme/theme.dart';
import 'package:yndx_todo/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key, this.environment = Environment.production});

  final Environment environment;

  @override
  Widget build(BuildContext context) {
    return DIContainer().diProvider(
      context,
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: state.brightness == Brightness.dark ? darkTheme : lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
