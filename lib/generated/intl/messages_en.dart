// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addtask": MessageLookupByLibrary.simpleMessage("add task"),
        "chooseDifficulty":
            MessageLookupByLibrary.simpleMessage("Choose difficulty"),
        "deadline": MessageLookupByLibrary.simpleMessage("deadline"),
        "delete": MessageLookupByLibrary.simpleMessage("delete"),
        "describeTask": MessageLookupByLibrary.simpleMessage("Describe task"),
        "done": MessageLookupByLibrary.simpleMessage("completed"),
        "easy": MessageLookupByLibrary.simpleMessage("easy"),
        "hard": MessageLookupByLibrary.simpleMessage("hard"),
        "homeHeader": MessageLookupByLibrary.simpleMessage("Your tasks "),
        "inwork": MessageLookupByLibrary.simpleMessage("in work"),
        "medium": MessageLookupByLibrary.simpleMessage("medium"),
        "newTask": MessageLookupByLibrary.simpleMessage("New\ntask"),
        "noCompletedTasks": MessageLookupByLibrary.simpleMessage(
            "There are no completed tasks"),
        "noDeadline": MessageLookupByLibrary.simpleMessage("without deadline"),
        "noInternet": MessageLookupByLibrary.simpleMessage(
            "Нестабильное интернет соединение. Данные синхронизируются с другими устройствами как только появится соединение"),
        "noUncompletedTasks": MessageLookupByLibrary.simpleMessage(
            "There are no unfulfilled tasks, \nyou are cool!"),
        "ohNo": MessageLookupByLibrary.simpleMessage("О нет!"),
        "save": MessageLookupByLibrary.simpleMessage("save"),
        "sync": MessageLookupByLibrary.simpleMessage(
            "Я немного заморочился и сделал имитацию работы на нескольких устройствах. Но получилось немного долговато, буду оптимизировать")
      };
}
