import 'package:flutter/material.dart';
import 'package:yndx_todo/features/add_task_page/presentation/add_task_page.dart';
import 'package:yndx_todo/features/home_page/presentation/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'sfpro', useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const AddTaskScreen(),
      },
    );
  }
}
