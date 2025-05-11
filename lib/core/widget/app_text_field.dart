import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTextField extends ConsumerStatefulWidget {
  final String initialValue;
  final String label;
  final StateProvider<String?> errorProvider;
  final ValueChanged<String> onChanged;

  const AppTextField({
    super.key,
    required this.initialValue,
    required this.label,
    required this.errorProvider,
    required this.onChanged,
  });

  @override
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: ref.watch(widget.errorProvider),
      ),
      onChanged: (value) {
        widget.onChanged(value);
        ref.read(widget.errorProvider.notifier).state = null;
      },
    );
  }
}
