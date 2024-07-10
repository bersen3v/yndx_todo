

//Если есть такая возможность, зайди сюда завтра... Буду очень благодарен





// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   final _task1 = Task(
//     text: 'task',
//     deadline: DateTime(2024),
//     changedAt: DateTime(2025),
//     createdAt: DateTime(2026),
//     done: true,
//     importance: Importance.important,
//     lastUpdatedBy: 'vanya',
//     id: 1,
//   );
//   final _task2 = Task(
//     text: 'task',
//     deadline: DateTime(2024),
//     changedAt: DateTime(2025),
//     createdAt: DateTime(2026),
//     done: true,
//     importance: Importance.important,
//     lastUpdatedBy: 'vanya',
//     id: 2,
//   );
//   final _task3 = Task(
//     text: 'task',
//     deadline: DateTime(2024),
//     changedAt: DateTime(2025),
//     createdAt: DateTime(2026),
//     done: true,
//     importance: Importance.important,
//     lastUpdatedBy: 'vanya',
//     id: 3,
//   );
//   final _task4 = Task(
//     text: 'task',
//     deadline: DateTime(2024),
//     changedAt: DateTime(2025),
//     createdAt: DateTime(2026),
//     done: true,
//     importance: Importance.important,
//     lastUpdatedBy: 'vanya',
//     id: 4,
//   );

//   group('OnTap по кнопке создания Todo', () {
//     testWidgets('должен создавать новый элемент TodoItem в списке задач',
//         (widgetTester) async {
//       //  arrange
//       final todos = [];

//       await widgetTester.pumpWidget(
//         const App(
//           environment: Environment.test,
//         ),
//       );

//       final widget1 = find.byType(Scaffold);
//       print(widget1);
//       final widget = find.byKey(const ValueKey('blyat'));
//       print(widget);

//       // await widgetTester.tap(fab);
//       // await widgetTester.pumpAndSettle(const Duration(seconds: 5));

//       // await widgetTester.enterText(
//       //     find.byKey(const ValueKey('task_text')), 'task test 12121231');
//       // await widgetTester.testTextInput.receiveAction(TextInputAction.done);
//       // await widgetTester.pumpAndSettle();

//       // await widgetTester.tap(find.byKey(const ValueKey('add_task')));
//       // await widgetTester.pumpAndSettle();

//       print('');

//       // final listFinder = find.byType(Scrollable);
//       // final key = ValueKey('item_$lastTodoId');
//       // final byKeyFinder = find.byKey(key);

//       // //  scroll to new created todo_item element
//       // await widgetTester.scrollUntilVisible(
//       //   byKeyFinder,
//       //   100.0,
//       //   scrollable: listFinder,
//       // );

//       // //  assert
//       // expect(byKeyFinder, findsOneWidget);
//     });
//   });

//   // group('OnTap по иконке завершения', () {
//   //   testWidgets('должен переводить модель Todo в завершенное состояние',
//   //       (widgetTester) async {
//   //     //  arrange
//   //     final todoList = DI.todoRepository.fetchAll();
//   //     await widgetTester.pumpWidget(
//   //       const MyApp(
//   //         environment: Environment.test,
//   //       ),
//   //     );

//   //     //  act
//   //     const completedTodosCount = 5;
//   //     final totalCount = todoList.length;

//   //     for (var i = 0; i < completedTodosCount; i++) {
//   //       //  комплитим таску
//   //       final itemIconFinder = find.byKey(ValueKey('item_icon_${i + 1}'));
//   //       await widgetTester.tap(itemIconFinder);
//   //       await widgetTester.pumpAndSettle();
//   //     }

//   //     //  assert
//   //     final items = widgetTester.allWidgets.whereType<TodoItemWidget>();
//   //     expect(items.length, totalCount);

//   //     final pageState = widgetTester.allStates.whereType<TodoPageState>().first;
//   //     expect(pageState.todos.where((e) => e.isCompleted).length,
//   //         completedTodosCount);
//   //   });
//   // });
// }
