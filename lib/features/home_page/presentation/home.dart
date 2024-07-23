import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';
import 'package:yndx_todo/core/firebase/analytics.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/navigation/navigation_manager.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/core/theme/cubit/change_theme_cubit.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                        child: AutoSizeText(
                          textAlign: TextAlign.center,
                          S.of(context).sync,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
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
                    style: const TextStyle(
                      color: Styles.white,
                      fontSize: 24,
                    ),
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
                  completedTasks:
                      data.tasks.where((e) => e.done == true).length,
                  allTasks: data.tasks.length,
                ),
                const _TaskList(),
              ],
            ),
            const _Button(
              key: ValueKey('home_button_add'),
            ),
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

        List<Widget> children = [
          const ThemeSwitcher(),
          const Gap(30),
          ViewSwitcher(
            inWork: '${tasks.length}',
            done: '${doneTasks.length}',
          ),
          context.read<HomePageBloc>().view == 0
              ? Tasks(
                  tasks: tasks,
                  doneTasks: doneTasks,
                )
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
                  launchUrl(
                    Uri.parse(
                      'https://bersen3v.github.io/deeplinks.github.io/',
                    ),
                  );
                } catch (e) {
                  logger.e(e);
                }
              },
              text:
                  'протестить диплинк. {Кнопка ведёт на сайт, который уводит в диплинк, ведущий на страницу добавления задачи}',
              color: Styles.grey06,
            ),
          ),
          const Gap(150),
        ];
        return SliverList.list(
          children: children,
        );
      },
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(20),
        Text(
          'Dark mode',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const Gap(5),
        Switch(
          activeColor: Styles.orange,
          inactiveTrackColor: Styles.white,
          trackOutlineColor: WidgetStateProperty.all(Styles.orange),
          inactiveThumbColor: Styles.orange,
          value: context.read<ChangeThemeCubit>().state.brightness ==
              Brightness.dark,
          onChanged: (bool state) {
            final cubit = context.read<ChangeThemeCubit>();
            cubit.changeThemeBrightness();
          },
        ),
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
      left: MediaQuery.of(context).orientation == Orientation.portrait
          ? 10
          : null,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return MediaQuery.of(context).orientation == Orientation.portrait
              ? CustomButton(
                  color: Styles.orange,
                  text: S.of(context).addtask,
                  onTap: () {
                    AnalyticsEvents.pushPage('add_task_page');
                    NavigationManager.goToAddTaskScreen(context);
                  },
                )
              : IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Styles.orange,
                    ),
                  ),
                  color: Styles.white,
                  onPressed: () {
                    AnalyticsEvents.pushPage('add_task_page');
                    NavigationManager.goToAddTaskScreen(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                );
        },
      ),
    );
  }
}
