import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample_flutter_test/features/todo/application/todo_application.dart';
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
          log('ListViewです');
          final docs = data.docs;
          print(docs.length);
          return docs.isEmpty
              ? const Center(child: Text('Todo is empty'))
              : ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final todo = docs[index].data();
                    log(todo.title);
                    print(todo.id);
                    print(todo.date);
                    print(DateFormat('yyyy/MM/dd HH:mm').format(todo.date));
                    return Dismissible(
                      key: ValueKey(todo.id),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) async {
                        await ref
                            .read(todoApplicationProvider)
                            .delete(context: context, id: todo.id);
                      },
                      child: ListTile(
                        // key: ValueKey(todo.id),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy/MM/dd HH:mm').format(todo.date),
                            ),
                            Text(todo.title),
                          ],
                        ),
                        onTap: () {},
                      ),
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
