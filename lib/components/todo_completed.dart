import 'package:flutter/material.dart';
import 'package:to_do/components/tile_completed.dart';
import 'package:to_do/pages/edit_todo.dart';
import 'package:to_do/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoCompleted extends StatelessWidget {
  const TodoCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> colorOptions = [Colors.blue, Colors.green, Colors.red];
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final completed = todoProvider.completed;
        if (completed.isEmpty) {
          return Center(child: Text("No Data Found"));
        }
        return ListView.builder(
          itemCount: completed.length,
          itemBuilder: (context, index) {
            final todo = completed[index];
            return CompletedTile(
              completed: todo,
            ); // hanya satu item, bukan seluruh list
          },
        );
      },
    );
  }
}
