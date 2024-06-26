import 'package:flutter/material.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';
import 'package:yndx_todo/core/styles/styles.dart';

class DifficultySlider extends StatefulWidget {
  const DifficultySlider({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<DifficultySlider> createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  @override
  Widget build(BuildContext context) {
    double value = switch (widget.task.importance) {
      Importance.low => 0,
      Importance.basic => 1,
      Importance.important => 2,
      null => 0,
    };

    Color color = switch (value) {
      0 => Styles.green,
      1 => Styles.systemOrange,
      2 => Styles.red,
      double() => throw UnimplementedError(),
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        _StopPoints(color: color),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 7,
            activeTrackColor: color,
            inactiveTrackColor: color,
            activeTickMarkColor: color,
            inactiveTickMarkColor: color,
            thumbColor: color,
            trackShape: const RoundedRectSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 17.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
          ),
          child: Slider(
            min: 0,
            max: 2,
            divisions: 2,
            value: value,
            onChanged: (value) {
              setState(
                () {
                  value = value;
                  switch (value) {
                    case 0:
                      color = Styles.green;
                      widget.task.importance = Importance.low;
                    case 1:
                      color = Styles.systemOrange;
                      widget.task.importance = Importance.basic;
                    case 2:
                      color = Styles.red;
                      widget.task.importance = Importance.important;
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StopPoints extends StatelessWidget {
  const _StopPoints({
    super.key,
    required Color color,
  }) : _color = color;

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _StopPoint(color: _color)),
        _StopPoint(color: _color),
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: _StopPoint(color: _color)),
      ],
    );
  }
}

class _StopPoint extends StatelessWidget {
  const _StopPoint({
    super.key,
    required Color color,
  }) : _color = color;

  final Color _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        color: _color,
      ),
      width: 10,
      height: 30,
    );
  }
}

class DifficultySliderDescription extends StatelessWidget {
  const DifficultySliderDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              'легкая',
              style: TextStyle(color: Styles.white),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'средняя',
              style: TextStyle(color: Styles.white),
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(
              'сложная',
              style: TextStyle(color: Styles.white),
            ),
          ),
        ],
      ),
    );
  }
}
