import 'package:flutter/material.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/presentation/widgets/header.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.completedTasks,
    required this.allTasks,
  });

  final int completedTasks;
  final int allTasks;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
        titlePadding: const EdgeInsets.only(bottom: 15),
        centerTitle: false,
        title: Header(
          completedTasks: completedTasks,
          allTasks: allTasks,
        ),
      ),
    );
  }
}
