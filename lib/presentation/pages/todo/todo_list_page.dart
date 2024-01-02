import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/application/todo_list.dart';

/// Todo一覧画面
class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
      ),
      body: todoList.when(
        data: (data) {
          final docs = data.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final todo = docs[index].data();
              return ListTile(
                title: Text(todo.title),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
