import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/services/new_task_service.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_divider.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_text_field.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/date_picker.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/description.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/difficulty_slider.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/header.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/custom_button.dart';
import 'package:yndx_todo/generated/l10n.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final Task task = (widget.task == null
        ? RepositoryProvider.of<NewTaskService>(context).task
        : widget.task!.clone());

    return _AddTaskScreenView(task: task, editMode: widget.task != null);
  }
}

class _AddTaskScreenView extends StatelessWidget {
  const _AddTaskScreenView(
      {super.key, required this.task, required this.editMode});

  final Task task;
  final bool editMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          children: [
            _BackButton(),
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
                    task: task,
                    controller: TextEditingController()..text = task.text ?? '',
                    labelText: S.of(context).describeTask,
                    onTap: () {},
                  ),
                  const Gap(30),
                  const CustomDivider(),
                  Description(text: S.of(context).chooseDifficulty),
                  const Gap(30),
                  DifficultySlider(
                    task: task,
                  ),
                  const DifficultySliderDescription(),
                  const Gap(30),
                  const CustomDivider(),
                  Description(text: S.of(context).deadline),
                  const Gap(20),
                  DatePicker(
                    task: task,
                  ),
                  const Gap(30),
                  !editMode
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

class _BackButton extends StatelessWidget {
  const _BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          CupertinoIcons.back,
          size: 40.0,
        ),
        onPressed: () {
          RepositoryProvider.of<NewTaskService>(context).resetTask();
          context.go('/');
        });
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
        RepositoryProvider.of<NewTaskService>(context).resetTask();
        context
            .read<HomePageBloc>()
            .add(RemoveTaskEvent(task: task, context: context));
      },
      text: S.of(context).delete,
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
        if (task.text != null) {
          RepositoryProvider.of<NewTaskService>(context).resetTask();
          context.go('/');
          context
              .read<HomePageBloc>()
              .add(ChangeTaskEvent(task: task, context: context));
        }
      },
      text: S.of(context).save,
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
      text: S.of(context).addtask,
      onTap: () {
        if (task.text != null) {
          context.go('/');
          RepositoryProvider.of<NewTaskService>(context).resetTask();
          context
              .read<HomePageBloc>()
              .add(AddTaskEvent(task: task, context: context));
        }
      },
    );
  }
}
