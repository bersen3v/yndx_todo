import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';

import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/custom_app_bar.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/custom_button.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CustomAppBar(
                completedTasks: 0,
                allTasks: 10,
              ),
              _TaskList(),
            ],
          ),
          _Button()
        ],
      ),
    );
  }
}

class _TaskList extends StatefulWidget {
  const _TaskList({
    super.key,
  });

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  dynamic data;
  Map<String, dynamic>? data2;

  final client = MyHttpClient();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    client.getAt(12345).then((value) async {
      data = value;
      setState(() {});
      (data as Task).id = 16032005;
      print(data);
      print(await client.post(data));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Gap(30),
        Tasks(
          tasks: [],
          doneTasks: [],
        ),
        Gap(10),
        Tasks(
          tasks: [],
          done: true,
          doneTasks: [],
        ),
        Gap(50),
        Text(
          data.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          data2.toString(),
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 10,
      left: 10,
      child: CustomButton(
        color: Styles.orange,
        text: 'добавить задачу',
        onTap: () {
          Navigator.pushNamed(context, '/create');
          // arguments: Task(
          //     taskDifficulty: TaskDifficulty.medium,
          //     taskText: 'asdsf',
          //     deadlineDate: DateTime.now()));
        },
      ),
    );
  }
}
