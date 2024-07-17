// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Your tasks `
  String get homeHeader {
    return Intl.message(
      'Your tasks ',
      name: 'homeHeader',
      desc: '',
      args: [],
    );
  }

  /// `in work`
  String get inwork {
    return Intl.message(
      'in work',
      name: 'inwork',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get done {
    return Intl.message(
      'completed',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `add task`
  String get addtask {
    return Intl.message(
      'add task',
      name: 'addtask',
      desc: '',
      args: [],
    );
  }

  /// `New\ntask`
  String get newTask {
    return Intl.message(
      'New\ntask',
      name: 'newTask',
      desc: '',
      args: [],
    );
  }

  /// `easy`
  String get easy {
    return Intl.message(
      'easy',
      name: 'easy',
      desc: '',
      args: [],
    );
  }

  /// `medium`
  String get medium {
    return Intl.message(
      'medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `hard`
  String get hard {
    return Intl.message(
      'hard',
      name: 'hard',
      desc: '',
      args: [],
    );
  }

  /// `Describe task`
  String get describeTask {
    return Intl.message(
      'Describe task',
      name: 'describeTask',
      desc: '',
      args: [],
    );
  }

  /// `Choose difficulty`
  String get chooseDifficulty {
    return Intl.message(
      'Choose difficulty',
      name: 'chooseDifficulty',
      desc: '',
      args: [],
    );
  }

  /// `deadline`
  String get deadline {
    return Intl.message(
      'deadline',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `without deadline`
  String get noDeadline {
    return Intl.message(
      'without deadline',
      name: 'noDeadline',
      desc: '',
      args: [],
    );
  }

  /// `There are no completed tasks`
  String get noCompletedTasks {
    return Intl.message(
      'There are no completed tasks',
      name: 'noCompletedTasks',
      desc: '',
      args: [],
    );
  }

  /// `There are no unfulfilled tasks, \nyou are cool!`
  String get noUncompletedTasks {
    return Intl.message(
      'There are no unfulfilled tasks, \nyou are cool!',
      name: 'noUncompletedTasks',
      desc: '',
      args: [],
    );
  }

  /// `Я немного заморочился и сделал имитацию работы на нескольких устройствах. Но получилось немного долговато, буду оптимизировать`
  String get sync {
    return Intl.message(
      'Я немного заморочился и сделал имитацию работы на нескольких устройствах. Но получилось немного долговато, буду оптимизировать',
      name: 'sync',
      desc: '',
      args: [],
    );
  }

  /// `Нестабильное интернет соединение. Данные синхронизируются с другими устройствами как только появится соединение`
  String get noInternet {
    return Intl.message(
      'Нестабильное интернет соединение. Данные синхронизируются с другими устройствами как только появится соединение',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `О нет!`
  String get ohNo {
    return Intl.message(
      'О нет!',
      name: 'ohNo',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
