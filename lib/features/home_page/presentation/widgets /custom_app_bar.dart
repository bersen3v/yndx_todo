import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets%20/header.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      centerTitle: false,
      floating: false,
      pinned: true,
      expandedHeight: 200,
      collapsedHeight: 90,
      elevation: 20,
      shadowColor: Colors.black,
      surfaceTintColor: Styles.scaffoldBackgroundColor,
      backgroundColor: Styles.scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 15),
        centerTitle: false,
        title: Header(),
      ),
    );
  }
}
