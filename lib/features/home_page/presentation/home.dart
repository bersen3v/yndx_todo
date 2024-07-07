import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/services/todo_service.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/custom_app_bar.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/custom_button.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/tasks.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/view_switcher.dart';

import 'package:yndx_todo/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeScreenView();
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.scaffoldBackgroundColor,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return switch (state) {
            RegisteringServicesState() => Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        S.of(context).sync,
                        style: const TextStyle(
                            color: Styles.grey06, fontSize: 25, height: 1),
                      ),
                      const Gap(20),
                      const CircularProgressIndicator(
                        color: Styles.orange,
                      ),
                    ],
                  ),
                ),
              ),
            TodosLoadedState() => const _LoadedView(),
          };
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final data = state as TodosLoadedState;
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                CustomAppBar(
                  completedTasks:
                      data.tasks.where((e) => e.done == true).length,
                  allTasks: data.tasks.length,
                ),
                const _TaskList(),
              ],
            ),
            const _Button()
          ],
        );
      },
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        final data = state as TodosLoadedState;
        final tasks = data.tasks.where((e) => e.done != true).toList();
        final doneTasks = data.tasks.where((e) => e.done == true).toList();
        return SliverList.list(
          children: [
            const Gap(30),
            ViewSwitcher(
              inWork: '${tasks.length}',
              done: '${doneTasks.length}',
            ),
            context.read<HomePageBloc>().view == 0
                ? Tasks(tasks: tasks, doneTasks: doneTasks)
                : Tasks(
                    tasks: doneTasks,
                    done: true,
                    doneTasks: doneTasks,
                  ),
            const Gap(150),
          ],
        );
      },
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
        text: S.of(context).addtask,
        onTap: () {
          context.push('/addtask');
        },
      ),
    );
  }
}
