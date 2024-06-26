import 'package:yndx_todo/core/enums/task_difficulty_enum.dart';

class Task {
  DateTime? deadlineDate;
  String? taskText;
  TaskDifficulty? taskDifficulty;

  Task({
    this.deadlineDate,
    required this.taskText,
    required this.taskDifficulty,
  });

  String? showDeadlineDate() {
    if (deadlineDate == null) {
      return null;
    }
    return '${deadlineDate?.day} ${numbersOfMonth[deadlineDate?.month]} ${deadlineDate?.year}';
  }
}

Map<int, String> numbersOfMonth = {
  1: 'Января',
  2: 'Февраля',
  3: 'Марта',
  4: 'Апреля',
  5: 'Мая',
  6: 'Июня',
  7: 'Июля',
  8: 'Августа',
  9: 'Сентября',
  10: 'Октября',
  11: 'Ноября',
  12: 'Декабря',
};
