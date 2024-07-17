import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:yndx_todo/core/enums/evvironment.dart';

import 'package:yndx_todo/core/navigation/router.dart';
import 'package:yndx_todo/core/services/new_task_service.dart';
import 'package:yndx_todo/core/services/todo_service.dart';
import 'package:yndx_todo/features/home_page/bloc/home_page_bloc.dart';
import 'package:yndx_todo/generated/l10n.dart';

import '../test/core/services/network_database_srvice_test.dart';

class TodoServiceMock extends Mock implements TodoService {}

class DIContainerMock {
  final TodoServiceMock todoService;
  DIContainerMock({
    required this.todoService,
  });
  final _newTaskService = NewTaskService();

  Widget diProvider(BuildContext context, {required Widget child}) {
    return BlocProvider(
      create: (context) => HomePageBloc(todoService),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => _newTaskService),
        ],
        child: child,
      ),
    );
  }
}

class AppMock extends StatelessWidget {
  const AppMock(
      {super.key,
      this.environment = Environment.test,
      required this.todoServiceMock});

  final Environment environment;
  final TodoServiceMock todoServiceMock;

  @override
  Widget build(BuildContext context) {
    return DIContainerMock(todoService: todoServiceMock).diProvider(
      context,
      child: MaterialApp.router(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          fontFamily: 'sfpro',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TodoServiceMock _todoServiceMock = TodoServiceMock();

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    when(() => _todoServiceMock.addTask(any()))
        .thenAnswer((_) async => FakeTask());
  });

  group('OnTap по кнопке создания Todo', () {
    testWidgets('должен создавать новый элемент TodoItem в списке задач',
        (widgetTester) async {
      await widgetTester.pumpWidget(AppMock(
        todoServiceMock: _todoServiceMock,
      ));

      // final item = find.byKey(const ValueKey('home_button_add'));
      // await widgetTester.tap(item);
    });
  });
}
