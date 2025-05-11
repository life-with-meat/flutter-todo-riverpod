import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/todo_state.dart';

final todoPageControllerProvider =
    StateNotifierProvider<TodoPageController, List<TodoState>>((ref) {
      return TodoPageController();
    });

final editErrorProvider = StateProvider<String?>((ref) => null);

class TodoPageController extends StateNotifier<List<TodoState>> {
  TodoPageController() : super([]);

  void add(String title) {
    final newTodo = TodoState(
      id: DateTime.now().toIso8601String(),
      title: title,
      isDone: false,
    );
    state = [...state, newTodo];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isDone: !todo.isDone) else todo,
    ];
  }

  void delete(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void edit(String id, String newTitle) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(title: newTitle) else todo,
    ];
  }
}
