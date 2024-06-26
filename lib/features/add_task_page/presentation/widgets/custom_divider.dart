import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 2,
      color: Styles.grey,
    );
  }
}
