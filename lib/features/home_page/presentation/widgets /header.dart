import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/generated/l10n.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.completedTasks,
    required this.allTasks,
  });

  final int completedTasks;
  final int allTasks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: RichText(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: S.of(context).homeHeader,
              style: const TextStyle(
                height: 1,
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "($completedTasks/$allTasks)",
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
