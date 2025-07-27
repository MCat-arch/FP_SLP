import 'package:flutter/material.dart';
import 'package:to_do/components/tile_task.dart';
import 'package:to_do/pages/edit_todo.dart';
import 'package:to_do/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoTask extends StatelessWidget {
  const TodoTask({super.key});

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          final todos = todoProvider.todos;
          if (todos.isEmpty) {
            return Center(child: Text("No Data Found"));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditTodo()),
                  );
                },
                child: TodoTile(todo: todo),
              );
            },
          );
        },
      ),
    );
  }
}
