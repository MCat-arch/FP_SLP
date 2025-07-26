import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_model.dart';
import 'package:to_do/provider/todo_provider.dart';

class CompletedTile extends StatelessWidget {
  const CompletedTile({super.key, required this.completed});

  final TodoModel completed;

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

    return GestureDetector(
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${completed.title}" berhasil dihapus'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () async {
                print('button undo  clicked');
                // implement function untuk mengembalikan data
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorOptions[completed.colors],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.4), width: 1),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    completed.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(completed.note, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        formatDate(completed.date),
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
                'Completed',
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
