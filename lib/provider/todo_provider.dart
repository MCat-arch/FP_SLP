import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todos = [];
  static const String _todoKey = 'todo_data';

  List<TodoModel> get todos =>
      _todos.where((t) => t.isCompleted != true).toList();

  List<TodoModel> get completed =>
      _todos.where((t) => t.isCompleted == true).toList();

  // TodoProvider() {
  //   initialState();
  // }

  Future initialState() async {
    await loadData();
    notifyListeners();
  }

  Future loadData() async {
    final _prefs = await SharedPreferences.getInstance();
    final todoDataJson = _prefs.getString(_todoKey) ?? '[]';
    final List<dynamic> jsonList = jsonDecode(todoDataJson);
    _todos = jsonList.map((data) => TodoModel.fromJson(data)).toList();
  }

  Future addData(TodoModel data) async {
    _todos.add(data);
    await _saveTodo();
    notifyListeners();
  }

  Future _saveTodo() async {
    final _prefs = await SharedPreferences.getInstance();
    final toJson = jsonEncode(_todos.map((t) => t.toJson()).toList());
    await _prefs.setString(_todoKey, toJson);
  }

  Future markCompleted(String id) async {
    final idx = _todos.indexWhere((d) => d.id == id);
    if (idx != -1) {
      _todos[idx].isCompleted = true;
      await _saveTodo();
      notifyListeners();
    }
  }

  List<TodoModel> searchData(String query) {
    List<TodoModel> filteredTodos =
        _todos
            .where(
              (t) =>
                  t.title.contains(query.toLowerCase()) ||
                  t.note.contains(query.toLowerCase()),
            )
            .toList();
    notifyListeners();
    return filteredTodos;
  }

  TodoModel? getById(String id) {
    try {
      return _todos.firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }
}
