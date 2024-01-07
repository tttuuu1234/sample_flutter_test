import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/features/todo/repository/todo_repository.dart';
import 'package:sample_flutter_test/presentation/components/snack_bar.dart';

final todoListStreamProvider = StreamProvider<QuerySnapshot<TodoDomain>>((ref) {
  return ref.read(todoRepositoryProvider).streamList();
});

final todoApplicationProvider = Provider<TodoApplication>((ref) {
  return TodoApplication(ref);
});

class TodoApplication {
  const TodoApplication(this._ref);

  final Ref _ref;

  /// Todoを追加する。
  Future<void> add({
    required BuildContext context,
    required String title,
  }) async {
    print('追加の処理');
    print(title);
    await _ref.read(todoRepositoryProvider).add(title: title);
    if (context.mounted) {
      showNormalSnackBar(context, 'Save success');
    }
  }

  /// Todoを削除する。
  Future<void> delete({
    required BuildContext context,
    required String id,
  }) async {
    await _ref.read(todoRepositoryProvider).delete(id);
    if (context.mounted) {
      showNormalSnackBar(context, 'Delete success');
    }
  }
}
