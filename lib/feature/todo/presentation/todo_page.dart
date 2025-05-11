import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/feature/todo/app/todo_page_controller.dart';
import 'package:todo_app/feature/todo/presentation/widget/todo_dialog.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoPageState = ref.watch(todoPageControllerProvider);
    final todoPageController = ref.read(todoPageControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo リスト'),
      ),

      body: Center(
        child: ListView.builder(
          itemCount: todoPageState.length,
          itemBuilder: (context, index) {
            final todo = todoPageState[index];
            return CheckboxListTile(
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              value: todo.isDone,
              activeColor: todo.isDone ? Colors.grey : null,
              tileColor: todo.isDone ? Colors.grey.shade300 : null,
              onChanged: (value) {
                todoPageController.toggle(todo.id);
              },
              secondary: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (String value) {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TodoDialog(
                          initialTitle: todo.title,
                          dialogTitle: 'タスクを編集',
                          errorProvider: editErrorProvider,
                          onSave: (newTitle) {
                            todoPageController.edit(todo.id, newTitle);
                          },
                        );
                      },
                    );
                  } else if (value == 'delete') {
                    todoPageController.delete(todo.id);
                  }
                },
                itemBuilder:
                    (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('編集'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('削除'),
                      ),
                    ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TodoDialog(
                initialTitle: '',
                dialogTitle: '新しいタスク',
                errorProvider: editErrorProvider,
                onSave: (newTitle) {
                  todoPageController.add(newTitle);
                },
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
