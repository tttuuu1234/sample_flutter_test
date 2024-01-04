import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_flutter_test/features/todo/application/todo_application.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/features/todo/repository/todo_repository.dart';
// import 'package:mockito/annotations.dart';
import 'package:sample_flutter_test/main.dart';
import 'package:sample_flutter_test/utils/provider.dart';

void main() {
  group('Todoの表示に関してのグループ。', () {
    late FakeFirebaseFirestore fakeFirestore;
    late Widget app;

    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();
      app = ProviderScope(
        overrides: [
          firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
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
      await fakeFirestore.collection('todos').doc('mock_id').set({
        'title': '掃除',
        'date': DateTime(2024, 1, 1, 18, 30),
      });
      // final res = await fakeFirestore.collection('todos').get();
      // print(res.docs.length);
      // print(res.docs.first.data());
      // print(res.docs.first.id);
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
  });
}
