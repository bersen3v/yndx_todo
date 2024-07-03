import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/logger/logger_inh_widget.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/domain/new_task_inh_widget.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_divider.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_text_field.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/date_picker.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/description.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/difficulty_slider.dart';
import 'package:yndx_todo/features/home_page/domain/tasks_inherited_widget.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/custom_button.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/header.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final model = TasksInheritedWidget.of(context)!.model;
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 40.0,
                ),
                onPressed: () => Navigator.pop(context)),
          ],
        ),
        backgroundColor: Styles.scaffoldBackgroundColor,
        foregroundColor: Styles.white,
        surfaceTintColor: Styles.scaffoldBackgroundColor,
      ),
      backgroundColor: Styles.scaffoldBackgroundColor,
      body: NewTaskInheritedWidget(
        task: task,
        child: Container(
          decoration: const BoxDecoration(
            color: Styles.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),
                    const Header(),
                    const Gap(35),
                    CustomTextField(
                      controller: TextEditingController()
                        ..text = task.taskText ?? '',
                      labelText: 'Опиши задачу',
                      onTap: () {},
                    ),
                    const Gap(30),
                    const CustomDivider(),
                    const Description(text: 'Определи сложность'),
                    const Gap(30),
                    const DifficultySlider(),
                    const DifficultySliderDescription(),
                    const Gap(30),
                    const CustomDivider(),
                    const Description(text: 'Дедлайн'),
                    const Gap(20),
                    DatePicker(task: task),
                    const Gap(30),
                    task.taskText == null
                        ? _OrangeButton(task: task, model: model)
                        : Column(
                            children: [
                              _GreenButton(model: model, task: task),
                              const Gap(10),
                              _RedButton(model: model, task: task),
                            ],
                          ),
                    const Gap(50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RedButton extends StatelessWidget {
  const _RedButton({
    super.key,
    required this.model,
    required this.task,
  });

  final Model model;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
        LoggerInhWidget.of(context)!
            .logger
            .d('Нажатие на кнопку "удалить задачу"');
        model.deleteTask(task);
        Navigator.of(context).pop();
      },
      text: 'Удалить',
      color: Styles.red,
    );
  }
}

class _GreenButton extends StatelessWidget {
  const _GreenButton({
    super.key,
    required this.model,
    required this.task,
  });

  final Model model;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
        LoggerInhWidget.of(context)!
            .logger
            .d('Нажатие на кнопку "сохранить задачу"');
        model.taskUpdate(task);
        Navigator.of(context).pop();
      },
      text: 'Сохранить',
      color: Styles.green,
    );
  }
}

class _OrangeButton extends StatelessWidget {
  const _OrangeButton({
    super.key,
    required this.task,
    required this.model,
  });

  final Task task;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Styles.orange,
      text: 'Добавить задачу',
      onTap: () {
        LoggerInhWidget.of(context)!
            .logger
            .d('Нажатие на кнопку "добавить задачу"');
        if (task.taskText != null && task.taskText != "") {
          model.addTask(task);
          Navigator.of(context).pop();
        }
      },
    );
  }
}
