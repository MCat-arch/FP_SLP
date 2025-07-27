import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_model.dart';
import 'package:to_do/provider/todo_provider.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todo});

  final TodoModel todo;

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate); // e.g., 12 Feb 2024
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colorOptions = [Colors.blue, Colors.red, Colors.orange];
    final provider = Provider.of<TodoProvider>(context, listen: false);
    return Dismissible(
      onDismissed: (direction) async {
        await provider.markCompleted(todo.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${todo.title}" ditandai selesai'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () async {
                final todoItem = provider.todos.firstWhere(
                  (t) => t.id == todo.id,
                  orElse: () => throw Exception('Not found'),
                );
                //implement function untuk update todo
              },
            ),
          ),
        );
      },
      key: ValueKey(todo.id),
      child: Container(
        decoration: BoxDecoration(
          color: colorOptions[todo.colors],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(todo.note, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        formatDate(todo.date),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: 2,
              height: 100,
              color: Colors.black.withOpacity(0.3),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Todo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
