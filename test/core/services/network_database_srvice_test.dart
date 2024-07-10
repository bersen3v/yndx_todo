import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yndx_todo/core/data/data_fetcher.dart';
import 'package:yndx_todo/core/domain/entities/task.dart';
import 'package:yndx_todo/core/enums/importance.dart';
import 'package:yndx_todo/core/logger.dart';
import 'package:yndx_todo/core/services/network_database_servise.dart';

class MyHttpClientMock extends Mock implements MyHttpClient {}

class FakeTask extends Mock implements Task {}

void main() {
  late NetworkDatabaseServise networkDb;
  late MyHttpClientMock clientMock;
  late Task task;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() async {
    try {
      clientMock = MyHttpClientMock();
      networkDb = NetworkDatabaseServise(client: clientMock);

      when(() => clientMock.post(any())).thenAnswer((_) async => FakeTask());
      when(() => clientMock.put(any())).thenAnswer((_) async => FakeTask());
      when(() => clientMock.delete(any())).thenAnswer((_) async => FakeTask());
      when(() => clientMock.get()).thenAnswer((_) async => [FakeTask()]);

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
    } catch (e) {
      logger.e(e);
    }
  });

  group(
    'NetworkDatabaseService',
    () {
      test(
        'addTask должен выполнить обращение к client.post с правильными аргументами',
        () async {
          await networkDb.addTask(task);

          final verification =
              verify(() => clientMock.post(captureAny())).captured;

          expect(verification.first, task);
        },
      );

      test(
        'updateTask должен выполнить обращение к client.put с правильными аргументами',
        () async {
          await networkDb.updateTask(task.copyWith(done: !task.done!));

          final verification =
              verify(() => clientMock.put(captureAny())).captured;

          expect(task, isNot(verification.first));
        },
      );

      test(
        'removeTask должен выполнить обращение к client.delete с правильными аргументами',
        () async {
          await networkDb.removeTask(task);

          final verification =
              verify(() => clientMock.delete(captureAny())).captured;

          expect(task, verification.first);
        },
      );
    },
  );
}
