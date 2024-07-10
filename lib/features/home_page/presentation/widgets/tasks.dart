import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:yndx_todo/core/extensions/on_datetime.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/generated/l10n.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    super.key,
    required this.tasks,
    this.done = false,
    required this.doneTasks,
  });

  final List<Task> doneTasks;
  final List<Task> tasks;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Styles.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: done && tasks.isEmpty
                ? EdgeInsets.zero
                : const EdgeInsets.only(top: 8, right: 8, left: 8),
            child: tasks.isEmpty
                ? SizedBox(
                    height: 150,
                    child: done
                        ? Center(
                            child: Text(
                              S.of(context).noCompletedTasks,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Styles.grey06,
                                fontSize: 25,
                                height: 1,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              S.of(context).noUncompletedTasks,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Styles.grey06,
                                fontSize: 25,
                                height: 1,
                              ),
                            ),
                          ),
                  )
                : Column(
                    children: tasks
                        .map(
                          (task) => _TaskView(
                            task: task,
                            done: done,
                            tasks: tasks,
                            doneTasks: doneTasks,
                          ),
                        )
                        .toList(),
                  ),
          ),
        )
      ],
    );
  }
}

class _TaskView extends StatelessWidget {
  const _TaskView({
    super.key,
    required this.task,
    this.done = false,
    required this.tasks,
    required this.doneTasks,
  });

  final List<Task> doneTasks;
  final List<Task> tasks;
  final Task task;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tasks.contains(task)
          ? () {
              if (!task.done!) context.push('/addtask', extra: task);
            }
          : () {},
      child: done
          ? Dismissible(
              direction: DismissDirection.endToStart,
              key: UniqueKey(),
              background: const _DismissibleBg(
                color: Styles.red,
                icon: Icons.delete,
                iconAlignment: Alignment.centerRight,
              ),
              child: _TaskCard(
                task: task,
                doneTasks: doneTasks,
              ),
              onDismissed: (direction) {
                context.read<HomePageBloc>().add(
                      RemoveTaskEvent(
                        task: task,
                        context: context,
                      ),
                    );
              },
            )
          : Dismissible(
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  context.read<HomePageBloc>().add(
                        RemoveTaskEvent(
                          task: task,
                          context: context,
                        ),
                      );
                } else {
                  context.read<HomePageBloc>().add(
                        ChangeTaskEvent(
                          task: task..done = !task.done!,
                          context: context,
                        ),
                      );
                }
              },
              secondaryBackground: const _DismissibleBg(
                color: Styles.red,
                icon: Icons.delete,
                iconAlignment: Alignment.centerRight,
              ),
              background: const _DismissibleBg(
                color: Styles.green,
                iconAlignment: Alignment.centerLeft,
                icon: Icons.done,
              ),
              key: UniqueKey(),
              child: _TaskCard(
                task: task,
                doneTasks: const [],
              ),
            ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    super.key,
    required this.task,
    required this.doneTasks,
  });

  final Task task;
  final List<Task> doneTasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Styles.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              doneTasks.contains(task)
                  ? const _DoneMark()
                  : _TaskDifficultyIndicator(
                      taskDifficulty: task.importance ?? Importance.low,
                    ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(6),
                    if (task.deadline != null)
                      _DeadlineText(ddl: task.deadline?.showDeadlineDate(task)),
                    _TaskDescriptionText(task: task.text ?? ''),
                    const Gap(6)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskDescriptionText extends StatelessWidget {
  const _TaskDescriptionText({
    super.key,
    required this.task,
  });

  final String task;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          task,
          style: const TextStyle(
            color: Styles.white,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}

class _DeadlineText extends StatelessWidget {
  const _DeadlineText({
    super.key,
    required this.ddl,
  });

  final String? ddl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        ddl!,
        style: const TextStyle(
          color: Styles.grey06,
          fontSize: 19,
        ),
      ),
    );
  }
}

class _DoneMark extends StatelessWidget {
  const _DoneMark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 40,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Styles.green,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.done,
          color: Styles.white,
          size: 30,
          weight: 30,
        ),
      ),
    );
  }
}

class _TaskDifficultyIndicator extends StatelessWidget {
  const _TaskDifficultyIndicator({
    super.key,
    required this.taskDifficulty,
  });

  final Importance taskDifficulty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 7,
        decoration: BoxDecoration(
          color: switch (taskDifficulty) {
            Importance.low => Styles.green,
            Importance.basic => Styles.systemOrange,
            Importance.important => Styles.red
          },
          borderRadius: BorderRadius.circular(90),
        ),
      ),
    );
  }
}

class _DismissibleBg extends StatelessWidget {
  const _DismissibleBg({
    super.key,
    required this.color,
    required this.iconAlignment,
    required this.icon,
  });

  final Color color;
  final Alignment iconAlignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17, top: 7),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: Container(
          alignment: iconAlignment,
          child: Padding(
            padding: iconAlignment == Alignment.centerRight
                ? const EdgeInsets.only(right: 15)
                : const EdgeInsets.only(left: 15),
            child: Icon(
              size: 25,
              icon,
              color: Styles.white,
              weight: 10,
            ),
          ),
        ),
      ),
    );
  }
}
