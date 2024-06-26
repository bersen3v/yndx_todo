import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Text(
        text,
        style: const TextStyle(color: Styles.white, fontSize: 20),
      ),
    );
  }
}
