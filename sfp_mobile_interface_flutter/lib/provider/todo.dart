import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final bool isCompleted;
  final String description;
  Todo(this.isCompleted, this.description);
}

final todoProvider = Provider<Todo>((ref) {
  return Todo(true, "공부하기");
});
