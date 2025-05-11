import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  factory TodoState({
    required String id,
    required String title,
    required bool isDone,
  }) = _TodoState;
}
