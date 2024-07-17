import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/generated/l10n.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        S.of(context).newTask,
        style: const TextStyle(
          height: 1,
          color: Styles.white,
          fontSize: 45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
