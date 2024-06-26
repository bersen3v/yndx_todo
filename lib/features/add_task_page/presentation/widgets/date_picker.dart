import 'package:flutter/material.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/extensions/on_datetime.dart';
import 'package:yndx_todo/features/add_task_page/presentation/widgets/custom_text_field.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.task});

  final Task task;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController datePickerController = TextEditingController();

  void onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
      initialDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    datePickerController.text =
        '${pickedDate.day} ${numbersOfMonth[pickedDate.month]}';
    widget.task.deadline = pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.task.deadline;
    return CustomTextField(
      controller: datePickerController
        ..text = (date != null)
            ? '${date.day} ${numbersOfMonth[date.month]}'
            : 'Без дедлайна',
      readOnly: true,
      onTap: () {
        onTapFunction(context: context);
      },
    );
  }
}
