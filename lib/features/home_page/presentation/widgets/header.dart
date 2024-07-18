import 'package:flutter/material.dart';
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
    const bool isDev = bool.fromEnvironment(
      'IS_DEV',
      defaultValue: false,
    );
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: RichText(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: S.of(context).homeHeader,
              style: TextStyle(
                height: 1,
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: theme.secondary,
              ),
            ),
            TextSpan(
              text: "($completedTasks/$allTasks)",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
                color: theme.onSecondary,
              ),
            ),
            const TextSpan(
              text: isDev ? '  [dev] ' : '',
              style: TextStyle(
                height: 1,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
