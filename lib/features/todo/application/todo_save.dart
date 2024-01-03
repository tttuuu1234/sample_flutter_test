import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/repository/todo.dart';
import 'package:sample_flutter_test/presentation/components/snack_bar.dart';

final todoSaveApplicationProvider = Provider<TodoSaveApplication>((ref) {
  return TodoSaveApplication(ref);
});

class TodoSaveApplication {
  const TodoSaveApplication(this._ref);

  final Ref _ref;

  /// Todoを追加する。
  Future<void> add({
    required BuildContext context,
    required String title,
  }) async {
    await _ref.read(todoRepositoryProvider).add(title: title);
    if (context.mounted) {
      showNormalSnackBar(context, 'Success!!');
      Navigator.pop(context);
    }
  }
}
