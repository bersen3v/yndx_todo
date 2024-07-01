import 'package:yndx_todo/core/domain/entities/task.dart';

extension ShowDeadlineDate on DateTime {
  String? showDeadlineDate(Task task) {
    if (task.deadline == null) {
      return null;
    }
    return '${task.deadline?.day} ${numbersOfMonth[task.deadline?.month]} ${task.deadline?.year}';
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
