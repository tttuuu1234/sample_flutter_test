import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/application/todo_application.dart';

class TodoSavePage extends ConsumerStatefulWidget {
  const TodoSavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoSavePageState();
}

class _TodoSavePageState extends ConsumerState<TodoSavePage> {
  late TextEditingController titleController;

  @override
  void initState() {
    titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo save'),
        actions: [
          TextButton(
            onPressed: titleController.text.isEmpty
                ? null
                : () async {
                    await ref
                        .read(todoApplicationProvider)
                        .add(context: context, title: titleController.text);
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              onChanged: (_) {
                // 画面更新するため。
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
