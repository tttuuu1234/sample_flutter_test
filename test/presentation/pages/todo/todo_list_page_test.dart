import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late Widget app;
  final todoTestUtils = TodoTestUtils();

  setUp(() async {
    fakeFirestore = todoTestUtils.getFakeFirestore();
    app = todoTestUtils.getAppToTodoTest(fakeFirestore);
    // Firestoreに擬似的にTodoの追加をしている。
    await fakeFirestore.collection('todos').doc('mock_id').set({
      'title': '掃除',
      'date': DateTime(2024, 1, 1, 18, 30),
    });
  });

  testWidgets('Todoにタイトルと日付が表示されるか。', (widgetTester) async {
    // アプリの起動。
    await widgetTester.pumpWidget(app);
    // 画面の描画中にCircularProgressIndicatorが一つ表示されているか。
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // 画面の描画完了待ち。
    await widgetTester.pumpAndSettle();
    // 画面の描画完了後、CircularProgressIndicatorが表示されていないか。
    expect(find.byType(CircularProgressIndicator), findsNothing);
    // 画面のTodo一覧に「掃除」のタイトルのTodoが一つ表示されているか。
    expect(find.text('掃除'), findsOneWidget);
    // 画面のTodo一覧に「2024/01/01 18:30」の日付のTodoが一つ表示されているか。
    expect(find.text('2024/01/01 18:30'), findsOneWidget);
  });

  testWidgets('Todoを左にドラッグしTodoが削除されるか。', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await widgetTester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    //「mock_id」のValueKeyを持つTodoの特定する。
    final key = find.byKey(const ValueKey('mock_id'));
    //「mock_id」のValueKeyを持つTodoを左にドラッグする。
    await widgetTester.drag(key, const Offset(-500, 0));
    // 画面の描画完了待ち。
    await widgetTester.pumpAndSettle();
    //「mock_id」のValueKeyを持つTodoが表示されていないか。
    expect(key, findsNothing);
  });
}
