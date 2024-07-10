import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yndx_todo/core/services/local_database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await getApplicationDocumentsDirectory();
  print(dir.path);

  await Hive.initFlutter();
  setUpAll(() async {
    print('setupall');
    try {
      await Hive.initFlutter();
    } catch (e) {
      print(e);
    }
  });

  test(
    'метод init  1) создает хранилище данных с именем, переданным в конструктор класса 2) Регистрирует TaskAdapter и ImportanceAdapter 3) Инициализирует переменную _tasks содержимым локального хранилища',
    () async {
      //arrange
      const String boxname = 'test';
      final LocalDatabaseService _localDb =
          LocalDatabaseService(boxname: boxname);

      //act
      print('startinit');
      await _localDb.init();
      print('init');

      //expect
      final tasks = _localDb.tasks.toList();

      expect(tasks.isEmpty, true);
      expect(!Hive.isAdapterRegistered(2), true);
      expect(!Hive.isAdapterRegistered(3), true);

      _localDb.closeDb();
    },
  );
}
