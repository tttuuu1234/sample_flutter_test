import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_flutter_test/features/todo/application/todo_application.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/main.dart';
import 'package:sample_flutter_test/utils/provider.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late Widget app;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    app = ProviderScope(
      overrides: [
        // Mock用のFirestoreに上書きしている。
        firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
        // Mock用のTodo一覧取得StreamProviderに上書きしている。
        todoListStreamProvider.overrideWith((ref) {
          return fakeFirestore
              .collection('todos')
              .withConverter<TodoDomain>(
                fromFirestore: (snapshot, _) => TodoDomain.fromDoc(snapshot),
                toFirestore: (value, _) => value.toJson()..remove('id'),
              )
              .orderBy('date', descending: true)
              .snapshots();
        }),
      ],
      child: const MyApp(),
    );
  });

  testWidgets('titleの変更が行えるか。', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    final finderFloatingActionButton = find.byType(FloatingActionButton);
    await widgetTester.tap(finderFloatingActionButton);
    await widgetTester.pumpAndSettle();
    final finderText = find.byKey(const ValueKey('TodoSavePageTitleKey'));
    final text = finderText.evaluate().single.widget as Text;
    expect(text.data, 'Todo save');
    final finder = find.byType(TextFormField);
    final titleTextFormFiled = finder.evaluate().single.widget as TextFormField;
    // TextFormFiledの初期値が空文字か。
    expect(titleTextFormFiled.initialValue, '');
    // TextFormFiledに「掃除」と入力している。
    await widgetTester.enterText(finder, '掃除');
    await widgetTester.pumpAndSettle();
    // TextFormFiledに「掃除」と表示されているか。
    expect(titleTextFormFiled.controller!.text, '掃除');
  });

  testWidgets('titleの未入力時は保存ボタンが非活性、入力時は活性化しているか。', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    final finderFloatingActionButton = find.byType(FloatingActionButton);
    await widgetTester.tap(finderFloatingActionButton);
    await widgetTester.pumpAndSettle();
    final finder = find.byKey(const ValueKey('TodoTitleFormKey'));
    final titleTextFormFiled = widgetTester.widget(finder) as TextFormField;
    final finderDisabledSaveButton = find.byType(TextButton);
    final disabledSaveButton =
        widgetTester.widget(finderDisabledSaveButton) as TextButton;
    // TextFormFiledに何も入力していない時は空文字になっているか。
    expect(titleTextFormFiled.controller!.text, '');
    // TextButtonが非活性になっているか。
    expect(disabledSaveButton.enabled, isFalse);

    // TextFormFiledに「掃除です」と入力する。
    await widgetTester.enterText(finder, '掃除です');
    titleTextFormFiled.onChanged!.call;
    await widgetTester.pumpAndSettle();
    // 画面更新後のTextButtonが活性化しているかどうか取得するには、再度widgetを取得しないといけないため。
    final finderSaveButton = find.byType(TextButton);
    final saveButton = widgetTester.widget(finderSaveButton) as TextButton;
    expect(titleTextFormFiled.controller!.text, '掃除です');
    // TextButtonが活性化しているか。
    expect(saveButton.enabled, isTrue);
  });

  testWidgets('Todoの保存ができるか。', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    expect(find.text('TodoList'), findsOneWidget);
    await widgetTester.pumpAndSettle();
    expect(find.text('Todo is empty'), findsOneWidget);
    await widgetTester.tap(find.byType(FloatingActionButton));
    await widgetTester.pumpAndSettle();
    await widgetTester.enterText(
      find.byKey(const ValueKey('TodoTitleFormKey')),
      '掃除です',
    );
    await widgetTester.pumpAndSettle();
    // TextButtonをタップしonPressedプロパティに設定されている処理を行わせる。
    // この場合は、追加の処理。
    await widgetTester.tap(find.byType(TextButton));
    await widgetTester.pump();
    // 追加に成功した場合、「Save success」がスナックバーに表示されているか。
    // widgetツリー内部ではTextは2つ存在している、、
    // TODO: SnackBarのwidgetを取得して、そこに表示されている文言が何のかをテストする方が方法としては正しいと思う。
    expect(find.text('Save success'), findsNWidgets(2));
    // 追加に成功した場合、Todo一覧画面に戻るので、戻った先の画面のタイトルに「TodoList」が
    // 表示されているか。
    await widgetTester.pump();
    expect(find.text('TodoList'), findsOneWidget);
    // 追加したTodoのタイトル、「掃除です」が表示されているか。
    // ListViewは再ビルドされていないが、テスト上は問題なく取得できて描画できている。
    // Firestoreのモック化の影響なのかな？
    expect(find.text('掃除です'), findsOneWidget);
  });
}
