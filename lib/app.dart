import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yndx_todo/core/di.dart';
import 'package:yndx_todo/core/enums/evvironment.dart';
import 'package:yndx_todo/core/router/router.dart';
import 'package:yndx_todo/generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key, this.environment = Environment.production});

  final Environment environment;

  @override
  Widget build(BuildContext context) {
    return DIContainer().diProvider(
      context,
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          fontFamily: 'sfpro',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
