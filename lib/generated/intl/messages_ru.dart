// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addtask": MessageLookupByLibrary.simpleMessage("добавить задачу"),
        "chooseDifficulty":
            MessageLookupByLibrary.simpleMessage("Определи сложность"),
        "deadline": MessageLookupByLibrary.simpleMessage("Дедлайн"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "describeTask": MessageLookupByLibrary.simpleMessage("Опиши задачу"),
        "done": MessageLookupByLibrary.simpleMessage("выполнены"),
        "easy": MessageLookupByLibrary.simpleMessage("легкая"),
        "hard": MessageLookupByLibrary.simpleMessage("сложная"),
        "homeHeader": MessageLookupByLibrary.simpleMessage("Твои задачи "),
        "inwork": MessageLookupByLibrary.simpleMessage("в работе"),
        "medium": MessageLookupByLibrary.simpleMessage("средняя"),
        "newTask": MessageLookupByLibrary.simpleMessage("Новая\nзадача"),
        "noCompletedTasks":
            MessageLookupByLibrary.simpleMessage("Выполненных задач нет"),
        "noDeadline": MessageLookupByLibrary.simpleMessage("Без дедлайна"),
        "noUncompletedTasks": MessageLookupByLibrary.simpleMessage(
            "Невыполненных задач нет,\\nты крут!"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "sync": MessageLookupByLibrary.simpleMessage(
            "Синхронизация данных на всех устройствах. Да, получилось долговато, извиняюсь... но работает))")
      };
}
