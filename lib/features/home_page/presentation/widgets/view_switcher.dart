import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/generated/l10n.dart';

class ViewSwitcher extends StatefulWidget {
  const ViewSwitcher({
    super.key,
    required this.inWork,
    required this.done,
  });

  final String inWork;
  final String done;

  @override
  State<ViewSwitcher> createState() => _ViewSwitcherState();
}

class _ViewSwitcherState extends State<ViewSwitcher> {
  int _selectedIndex = 0;

  void _change() {
    _selectedIndex = _selectedIndex == 0 ? 1 : 0;
    context.read<HomePageBloc>().add(ToggleScreenEvent());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = context.read<HomePageBloc>().view;
    String left = S.of(context).inwork;
    String right = S.of(context).done;
    final List<String> variants = [
      '$left (${widget.inWork})',
      '$right (${widget.done})'
    ];
    List<Widget> view = List.generate(
      variants.length,
      (int index) => index == _selectedIndex
          ? _Tab(
              title: variants[index],
              selected: true,
            )
          : _Tab(title: variants[index]),
    );
    return GestureDetector(
      onTap: () {
        _change();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _RoundedCorner(
            alignment: AlignmentDirectional.bottomEnd,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Styles.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: view,
              ),
            ),
          ),
          const _RoundedCorner(alignment: AlignmentDirectional.bottomStart)
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    super.key,
    required this.title,
    this.selected = false,
  });

  final bool selected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return selected
        ? Container(
            decoration: BoxDecoration(
              color: Styles.orange,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 6, 22, 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Styles.white,
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(
              22,
              6,
              22,
              8,
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Styles.grey06, fontSize: 18),
                ),
              ],
            ),
          );
  }
}

class _RoundedCorner extends StatelessWidget {
  const _RoundedCorner({
    super.key,
    required this.alignment,
  });

  final AlignmentDirectional alignment;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      children: [
        Container(
          width: 15,
          height: 15,
          color: Styles.grey,
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Styles.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(90),
          ),
        ),
      ],
    );
  }
}
