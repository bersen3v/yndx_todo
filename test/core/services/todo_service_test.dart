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
  late NetworkDatabaseServise networkDb;
  late MyHttpClient clientMock;

  late LocalDatabaseService localDb;
  late LocalDatabaseService localNetworkCopy;
  late LocalDatabaseService localDeletedDb;
  late LocalDataFetcherMock localDataFetcher;

  late TodoService todoService;

  late Task task1;
  late Task task2;
  late Task task3;
  late Task task4;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(
    () async {
      task1 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 1,
      );
      task2 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 2,
      );
      task3 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 3,
      );
      task4 = Task(
        text: 'task',
        deadline: DateTime(2024),
        changedAt: DateTime(2025),
        createdAt: DateTime(2026),
        done: true,
        importance: Importance.important,
        lastUpdatedBy: 'vanya',
        id: 4,
      );

      clientMock = MyHttpClient();
      networkDb = NetworkDatabaseServise(client: clientMock);

      localDataFetcher = LocalDataFetcherMock();
      localNetworkCopy = LocalDatabaseService(db: localDataFetcher);
      localDb = LocalDatabaseService(db: localDataFetcher);
      localDeletedDb = LocalDatabaseService(db: localDataFetcher);

      todoService = TodoService(
        localDb: localDb,
        localDeletedDd: localDeletedDb,
        localNetworkCopy: localNetworkCopy,
        networkDb: networkDb,
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
            task1,
            task2,
          ];

          final network = [
            task2,
            task3,
            task4,
          ];

          await todoService.analyzeConflicts(local, network);

          expect(todoService.union, [task1, task2, task3, task4]);
          expect(todoService.addToLocal, [task3, task4]);
          expect(todoService.addToNetwork, [task1]);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final List<Task> local = [];

          final List<Task> network = [];

          await todoService.analyzeConflicts(local, network);

          expect(todoService.union, []);
          expect(todoService.addToLocal, []);
          expect(todoService.addToNetwork, []);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final local = [
            task1,
          ];

          final network = [
            task1,
          ];

          await todoService.analyzeConflicts(local, network);

          expect(todoService.union, [task1]);
          expect(todoService.addToLocal, []);
          expect(todoService.addToNetwork, []);
        },
      );

      test(
        'analyzeConflicts анализирует содержимое локальной и удаленной баз данных и возвращает их объединение и недостающие части баз данных, если такие имеются',
        () async {
          final local = [
            task1,
            task2,
            task3,
          ];

          final List<Task> network = [];

          await todoService.analyzeConflicts(local, network);

          expect(todoService.union, [task1, task2, task3]);
          expect(todoService.addToLocal, []);
          expect(todoService.addToNetwork, [task1, task2, task3]);
        },
      );
    },
  );
}
