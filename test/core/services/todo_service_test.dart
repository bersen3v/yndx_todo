import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';
import 'package:yndx_todo/core/data/local_data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:yndx_todo/core/services/local_database_service.dart';
import 'package:yndx_todo/core/services/network_database_servise.dart';
import 'package:yndx_todo/core/services/todo_service.dart';

import 'network_database_srvice_test.dart';

class LocalDataFetcherMock extends Mock implements LocalDataFetcher {}

//TodoService создан чтобы одновременно управлять локальным и удаленным хранилищем
//с помощью одного вызова.

//Методы TodoService состоят из функций, протестированных в
//[local_database_service_test.dart] и [network_database_service_test.dart]

//Исключением является метод, отвечающий за валидацию и сопоставление информации из разных источников

void main() {
  late NetworkDatabaseServise _networkDb;
  late MyHttpClient _clientMock;

  late LocalDatabaseService _localDb;
  late LocalDatabaseService _localNetworkCopy;
  late LocalDatabaseService _localDeletedDb;
  late LocalDataFetcherMock _localDataFetcher;

  late TodoService _todoService;

  late Task _task1;
  late Task _task2;
  late Task _task3;
  late Task _task4;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(
    () async {
      _task1 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 1,
      );
      _task2 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 2,
      );
      _task3 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 3,
      );
      _task4 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 4,
      );

      _clientMock = MyHttpClient();
      _networkDb = NetworkDatabaseServise(client: _clientMock);

      _localDataFetcher = LocalDataFetcherMock();
      _localNetworkCopy = LocalDatabaseService(db: _localDataFetcher);
      _localDb = LocalDatabaseService(db: _localDataFetcher);
      _localDeletedDb = LocalDatabaseService(db: _localDataFetcher);

      _todoService = TodoService(
        localDb: _localDb,
        localDeletedDd: _localDeletedDb,
        localNetworkCopy: _localNetworkCopy,
        networkDb: _networkDb,
      );

      // when(() => _clientMock.post(any())).thenAnswer((_) async => FakeTask());
      // when(() => _clientMock.put(any())).thenAnswer((_) async => FakeTask());
      // when(() => _clientMock.delete(any())).thenAnswer((_) async => FakeTask());
      // when(() => _clientMock.get())
      //     .thenAnswer((_) async => [FakeTask(), FakeTask(), FakeTask()]);

      // when(() => _localDataFetcher.addTask(any()))
      //     .thenAnswer((_) async => FakeTask());

      // when(() => _localDataFetcher.tasks())
      //     .thenAnswer((_) => [FakeTask(), FakeTask(), FakeTask()]);

      // when(() => _localDataFetcher.removeTask(any()))
      //     .thenAnswer((_) async => FakeTask());

      // when(() => _localDataFetcher.updateTask(any()))
      //     .thenAnswer((_) async => FakeTask());

      // await _todoService.init();
    },
  );

  group(
    'TodoService',
    () {
      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final local = [
            _task1,
            _task2,
          ];

          final network = [
            _task2,
            _task3,
            _task4,
          ];

          await _todoService.analyzeConflicts(local, network);

          expect(_todoService.union, [_task1, _task2, _task3, _task4]);
          expect(_todoService.addToLocal, [_task3, _task4]);
          expect(_todoService.addToNetwork, [_task1]);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final List<Task> local = [];

          final List<Task> network = [];

          await _todoService.analyzeConflicts(local, network);

          expect(_todoService.union, []);
          expect(_todoService.addToLocal, []);
          expect(_todoService.addToNetwork, []);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final local = [
            _task1,
          ];

          final network = [
            _task1,
          ];

          await _todoService.analyzeConflicts(local, network);

          expect(_todoService.union, [_task1]);
          expect(_todoService.addToLocal, []);
          expect(_todoService.addToNetwork, []);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final local = [
            _task1,
            _task2,
            _task3,
          ];

          final List<Task> network = [];

          await _todoService.analyzeConflicts(local, network);

          expect(_todoService.union, [_task1, _task2, _task3]);
          expect(_todoService.addToLocal, []);
          expect(_todoService.addToNetwork, [_task1, _task2, _task3]);
        },
      );
    },
  );
}
