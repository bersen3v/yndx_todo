import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';
import 'package:yndx_todo/core/logger/logger_inh_widget.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/presentation/add_task_page.dart';
import 'package:yndx_todo/features/home_page/domain/tasks_inherited_widget.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    super.key,
    required this.tasks,
    this.done = false,
  });

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
                        ? const SizedBox()
                        : const Center(
                            child: Text(
                              'Невыполненных задач нет,\nты крут!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Styles.grey06,
                                  fontSize: 25,
                                  height: 1),
                            ),
                          ),
                  )
                : Column(
                    children: tasks
                        .map((task) => _TaskView(task: task, done: done))
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
  });

  final Task task;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final model = TasksInheritedWidget.of(context)!.model;
    return GestureDetector(
      onTap: model.tasks.contains(task)
          ? () {
              LoggerInhWidget.of(context)!
                  .logger
                  .d('Нажатие на кнопку "редактировать задачу"');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                    task: task,
                  ),
                ),
              );
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
              child: _TaskCard(task: task),
              onDismissed: (direction) {
                model.deleteDoneTask(task);
                LoggerInhWidget.of(context)!
                    .logger
                    .d('Свайп по выполненной задаче => задача удалена');
              },
            )
          : Dismissible(
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  LoggerInhWidget.of(context)!
                      .logger
                      .d('Свайп по задаче => удаление задачи');
                  model.deleteTask(task);
                } else {
                  LoggerInhWidget.of(context)!
                      .logger
                      .d('Свайп по задаче => задача выполнена');
                  model.completeTask(task);
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
                  icon: Icons.done),
              key: UniqueKey(),
              child: _TaskCard(
                task: task,
              ),
            ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final model = TasksInheritedWidget.of(context)!.model;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Styles.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(13)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              model.doneTasks.contains(task)
                  ? const _DoneMark()
                  : _TaskDifficultyIndicator(
                      taskDifficulty:
                          task.taskDifficulty ?? TaskDifficulty.light),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(6),
                    if (task.deadlineDate != null)
                      _DeadlineText(ddl: task.showDeadlineDate()),
                    _TaskDescriptionText(task: task.taskText ?? ''),
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

  final TaskDifficulty taskDifficulty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 7,
        decoration: BoxDecoration(
            color: switch (taskDifficulty) {
              TaskDifficulty.light => Styles.green,
              TaskDifficulty.medium => Styles.systemOrange,
              TaskDifficulty.hard => Styles.red
            },
            borderRadius: BorderRadius.circular(90)),
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
