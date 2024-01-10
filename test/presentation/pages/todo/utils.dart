import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/application/todo_application.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/main.dart';
import 'package:sample_flutter_test/utils/provider.dart';

class TodoTestUtils {
  /// Mock用のFirestoreインスタンスの取得をする。
  FakeFirebaseFirestore getFakeFirestore() => FakeFirebaseFirestore();

  /// Todo関連の画面のテスト用のappを取得する。
  Widget getAppToTodoTest(FakeFirebaseFirestore fakeFirebaseFirestore) {
    return ProviderScope(
      overrides: [
        // Mock用のFirestoreに上書きしている。
        firestoreProvider.overrideWithValue(getFakeFirestore()),
        // Mock用のTodo一覧取得StreamProviderに上書きしている。
        todoListStreamProvider.overrideWith((ref) {
          return fakeFirebaseFirestore
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
  }
}
