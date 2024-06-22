import 'package:flutter/material.dart';
import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';
import 'package:yndx_todo/core/logger/logger_inh_widget.dart';
import 'package:yndx_todo/core/styles/styles.dart';
import 'package:yndx_todo/features/add_task_page/domain/new_task_inh_widget.dart';

class DifficultySlider extends StatefulWidget {
  const DifficultySlider({
    super.key,
  });

  @override
  State<DifficultySlider> createState() => _DifficultySliderState();
}

class _DifficultySliderState extends State<DifficultySlider> {
  @override
  Widget build(BuildContext context) {
    final task = NewTaskInheritedWidget.of(context)?.task;

    double value = switch (task!.taskDifficulty) {
      TaskDifficulty.light => 0,
      TaskDifficulty.medium => 1,
      TaskDifficulty.hard => 2,
      null => throw UnimplementedError(),
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
              LoggerInhWidget.of(context)!
                  .logger
                  .d('изменение сложности задачи на $value');
              setState(
                () {
                  value = value;
                  switch (value) {
                    case 0:
                      color = Styles.green;
                      task.taskDifficulty = TaskDifficulty.light;
                    case 1:
                      color = Styles.systemOrange;
                      task.taskDifficulty = TaskDifficulty.medium;
                    case 2:
                      color = Styles.red;
                      task.taskDifficulty = TaskDifficulty.hard;
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
