import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Новая\nзадача',
        style: TextStyle(
            height: 1,
            color: Styles.white,
            fontSize: 45,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
