import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_divider.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_text_field.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/date_picker.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/description.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/difficulty_slider.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/header.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/custom_button.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final task = (ModalRoute.of(context)?.settings.arguments ??
        Task(
          importance: null,
          text: null,
        )) as Task;

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
      body: Container(
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
                    controller: TextEditingController()..text = task.text ?? '',
                    labelText: 'Опиши задачу',
                    onTap: () {},
                  ),
                  const Gap(30),
                  const CustomDivider(),
                  const Description(text: 'Определи сложность'),
                  const Gap(30),
                  DifficultySlider(task: task),
                  const DifficultySliderDescription(),
                  const Gap(30),
                  const CustomDivider(),
                  const Description(text: 'Дедлайн'),
                  const Gap(20),
                  DatePicker(task: task),
                  const Gap(30),
                  task.text == null
                      ? _OrangeButton(task: task)
                      : Column(
                          children: [
                            _GreenButton(task: task),
                            const Gap(10),
                            _RedButton(task: task),
                          ],
                        ),
                  const Gap(50),
                ],
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
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
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
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: () {
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
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      color: Styles.orange,
      text: 'Добавить задачу',
      onTap: () {
        if (task.text != null && task.text != "") {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
