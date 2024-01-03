import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample_flutter_test/features/todo/application/todo_list.dart';
import 'package:sample_flutter_test/presentation/pages/todo/todo_save_page.dart';

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
                key: ValueKey(todo.id),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat('yyyy/MM/dd').format(todo.date)),
                    Text(todo.title),
                  ],
                ),
                onTap: () {},
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const TodoSavePage();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
