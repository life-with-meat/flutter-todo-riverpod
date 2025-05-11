import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widget/app_text_field.dart';

class TodoDialog extends ConsumerWidget {
  final String initialTitle;
  final String dialogTitle;
  final Function(String) onSave;
  final StateProvider<String?> errorProvider;

  const TodoDialog({
    super.key,
    required this.initialTitle,
    required this.dialogTitle,
    required this.onSave,
    required this.errorProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String editedTitle = initialTitle;
    return AlertDialog(
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            initialValue: initialTitle,
            label: 'タスク名',
            errorProvider: errorProvider,
            onChanged: (value) {
              editedTitle = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(errorProvider.notifier).state = null;
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            if (editedTitle.trim().isEmpty) {
              ref.read(errorProvider.notifier).state = 'タスク名を入力してください';
              return;
            }
            onSave(editedTitle.trim());
            ref.read(errorProvider.notifier).state = null;
            Navigator.of(context).pop();
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
