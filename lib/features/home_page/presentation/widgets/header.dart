import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/domain/tasks_inherited_widget.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = TasksInheritedWidget.of(context)!.model;
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: RichText(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: <TextSpan>[
            const TextSpan(
              text: "Твои задачи ",
              style: TextStyle(
                height: 1,
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "(${model.completedTasks}/${model.allTasks})",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: Styles.grey06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
