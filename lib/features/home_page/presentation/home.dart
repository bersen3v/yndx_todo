import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';
import 'package:yndx_todo/core/logger/logger_inh_widget.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/presentation/add_task_page.dart';
import 'package:yndx_todo/features/home_page/domain/tasks_inherited_widget.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/custom_app_bar.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/custom_button.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final model = Model();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.scaffoldBackgroundColor,
      body: LoggerInhWidget(
        logger: Logger(),
        child: TasksInheritedWidget(
          model: model,
          child: Navigator(
            onPopPage: (route, result) => true,
            pages: const [
              MaterialPage(
                child: _HomeScreenView(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CustomScrollView(
          slivers: [
            CustomAppBar(),
            _TaskList(),
          ],
        ),
        _Button()
      ],
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = TasksInheritedWidget.of(context)!.model;
    return SliverList.list(
      children: [
        const Gap(30),
        Tasks(
          tasks: model.tasks,
        ),
        const Gap(10),
        Tasks(
          tasks: model.doneTasks,
          done: true,
        ),
        const Gap(50),
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
          LoggerInhWidget.of(context)!
              .logger
              .d('Нажатие на кнопку "добавить задачу"');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                task: Task(
                  taskText: null,
                  taskDifficulty: TaskDifficulty.light,
                  deadlineDate: null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
