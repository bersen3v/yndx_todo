import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';
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

class _HomeScreenView extends StatefulWidget {
  const _HomeScreenView({
    super.key,
  });

  @override
  State<_HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<_HomeScreenView> {
  bool networkMessageWork = false;
  bool network = true;

  void showNetworkMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          10,
          0,
          10,
          130,
        ),
        backgroundColor: Styles.orange,
        content: const _ConnectionSnackBar(),
      ),
    );
  }

  Future<void> hasNetwork(BuildContext context) async {
    if (!networkMessageWork) {
      networkMessageWork = true;
      MyHttpClient().get().then(
        (value) {
          if (value == null) {
            network = false;
            showNetworkMessage(context);
          } else {
            if (network == false) {
              context.read<HomePageBloc>().add(RegisterServicesEvent());
              network = true;
            }
          }
          //с помощью этой фьючи сообщения об отсутствии интернета появляются не чаще чем раз в 10 секунд.
          //Так что прошу сильно не пинать за future.delayed
          Future.delayed(
            const Duration(seconds: 10),
            () {
              networkMessageWork = false;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomePageBloc>().add(RegisterServicesEvent());
    return Scaffold(
      backgroundColor: Styles.scaffoldBackgroundColor,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          hasNetwork(context);
          return switch (state) {
            RegisteringServicesState() => Center(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          S.of(context).sync,
                          style: const TextStyle(
                            color: Styles.grey06,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
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

class _ConnectionSnackBar extends StatelessWidget {
  const _ConnectionSnackBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Styles.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_square_fill,
              color: Styles.white,
              size: 48,
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).ohNo,
                    style: const TextStyle(color: Styles.white, fontSize: 24),
                  ),
                  Text(
                    S.of(context).noInternet,
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  key: const ValueKey('blyat'),
                  completedTasks:
                      data.tasks.where((e) => e.done == true).length,
                  allTasks: data.tasks.length,
                ),
                const _TaskList(),
              ],
            ),
            const _Button(
              key: ValueKey('blyat'),
            )
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onTap: () {
                  try {
                    launchUrl(Uri.parse(
                        'https://bersen3v.github.io/deeplinks.github.io/'));
                  } catch (e) {
                    print(e);
                  }
                },
                text:
                    'протестить диплинк. {Кнопка ведёт на сайт, который уводит в диплинк, ведущий на страницу добавления задачи}',
                color: Styles.grey06,
              ),
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
