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
  testWidgets('日付の昇順で表示されているか。', (widgetTester) async {});

  testWidgets('Todoにタイトルと日付が表示されるか。', (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: MyApp()));
    expect(find.text('TodoList'), findsOneWidget);
  });

  group('Todoの表示に関してのグループ。', () {
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();
      await fakeFirestore.collection('todos').doc('mock_id').set({
        'title': '掃除',
        'date': DateTime(2024, 1, 1, 18, 30),
      });
      final res = await fakeFirestore.collection('todos').get();
      // print(res.docs.length);
      // print(res.docs.first.data());
      // print(res.docs.first.id);
    });

    testWidgets('Todoにタイトルと日付が表示されるか。', (widgetTester) async {
      await widgetTester.pumpWidget(
        ProviderScope(
          overrides: [
            firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
            todoListStreamProvider.overrideWith((ref) {
              return fakeFirestore
                  .collection('todos')
                  .withConverter<TodoDomain>(
                    fromFirestore: (snapshot, _) =>
                        TodoDomain.fromDoc(snapshot),
                    toFirestore: (value, _) => value.toJson()..remove('id'),
                  )
                  .orderBy('date', descending: true)
                  .snapshots();
            }),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.idle();
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('掃除'), findsOneWidget);
      expect(find.text('2024/01/01 18:30'), findsOneWidget);
    });

    testWidgets('TodoをスワイプしTodoが削除されるか。', (widgetTester) async {
      await widgetTester.pumpWidget(
        ProviderScope(
          overrides: [
            firestoreProvider.overrideWithValue(FakeFirebaseFirestore()),
            todoListStreamProvider.overrideWith((ref) {
              return fakeFirestore
                  .collection('todos')
                  .withConverter<TodoDomain>(
                    fromFirestore: (snapshot, _) =>
                        TodoDomain.fromDoc(snapshot),
                    toFirestore: (value, _) => value.toJson()..remove('id'),
                  )
                  .orderBy('date', descending: true)
                  .snapshots();
            }),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.idle();
      await widgetTester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      final key = find.byKey(const ValueKey('mock_id'));
      await widgetTester.drag(key, const Offset(-500, 0));
      await widgetTester.pumpAndSettle();
      expect(key, findsNothing);
    });
  });
}
