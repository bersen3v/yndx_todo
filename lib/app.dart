import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/presentation/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'sfpro', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Styles.scaffoldBackgroundColor,
        child: const SafeArea(
          bottom: false,
          child: HomeScreen(),
        ),
      ),
    );
  }
}
