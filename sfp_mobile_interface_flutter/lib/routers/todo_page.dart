import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfp_mobile_interface_flutter/provider/todo.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Todo todo = ref.read(todoProvider);
    return Scaffold(
      body: Center(
        child: Text(
          "완료: ${todo.isCompleted}, 내용: ${todo.description}",
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
