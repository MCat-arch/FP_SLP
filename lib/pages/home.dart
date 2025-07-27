import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/components/todo_completed.dart';
import 'package:to_do/components/todo_task.dart';
import 'package:to_do/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum Status { todo, completed }

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  Status StatusAt = Status.todo;
  // bool isDarkMode = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int todoCount = context.select<TodoProvider, int>(
      (p) => p.todos.length,
    );
    final int completedCount = context.select<TodoProvider, int>(
      (value) => value.completed.length,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color.fromARGB(256, 65, 65, 65)),
            ),
            child: ListTile(
              title: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
              ),
              trailing: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        StatusAt = Status.todo;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'To Do',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                StatusAt == Status.todo
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                StatusAt == Status.todo
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            todoCount.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        StatusAt = Status.completed;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                StatusAt == Status.completed
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                StatusAt == Status.completed
                                    ? Colors.black
                                    : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            completedCount.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StatusAt == Status.todo ? TodoTask() : TodoCompleted(),
          ),
        ],
      ),
    );
  }
}
