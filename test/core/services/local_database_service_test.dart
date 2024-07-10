import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yndx_todo/core/data/local_data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/services/local_database_service.dart';

import 'network_database_srvice_test.dart';

class LocalDataFetcherMock extends Mock implements LocalDataFetcher {}

void main() {
  late LocalDatabaseService _dbService;
  late LocalDataFetcherMock _dataFetcher;
  late Task task;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(
    () {
      try {
        _dataFetcher = LocalDataFetcherMock();
        _dbService = LocalDatabaseService(db: _dataFetcher);

        task = Task(
          text: 'task',
          deadline: DateTime(2024),
          changedAt: DateTime(2025),
          createdAt: DateTime(2026),
          done: true,
          importance: Importance.important,
          lastUpdatedBy: 'vanya',
          id: 123,
        );

        when(() => _dataFetcher.addTask(any()))
            .thenAnswer((_) async => FakeTask());

        when(() => _dataFetcher.tasks()).thenAnswer((_) => [task]);

        when(() => _dataFetcher.removeTask(any()))
            .thenAnswer((_) async => FakeTask());

        when(() => _dataFetcher.updateTask(any()))
            .thenAnswer((_) async => FakeTask());
      } catch (e) {
        logger.e(e);
      }
    },
  );

  group(
    'LocalDatabaseService',
    () {
      test(
        'метод addTask должен выполнить обращение к базе с правильными аргументами',
        () async {
          await _dbService.addTask(task);

          final verification =
              verify(() => _dataFetcher.addTask(captureAny())).captured;

          expect(verification.first, task);
        },
      );

      test(
        'метод removeTask должен выполнить обращение к базе с правильными аргументами',
        () async {
          await _dbService.removeTask(task);

          final verification =
              verify(() => _dataFetcher.removeTask(captureAny())).captured;

          expect(verification.first, task);
        },
      );

      test(
        'метод updateTask должен выполнить обращение к базе с правильными аргументами',
        () async {
          await _dbService.updateTask(task);

          final verification =
              verify(() => _dataFetcher.updateTask(captureAny())).captured;

          expect(verification.first, task);
        },
      );
    },
  );
}
