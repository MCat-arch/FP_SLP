import 'package:flutter/material.dart';

class TodoModel {
  String id;
  String title;
  String note;
  String date;
  int colors;
  bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.colors,
    required this.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'],
    title: json['title'],
    note: json['note'],
    date: json['date'],
    colors: json['colors'],
    isCompleted: json['isCompleted'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'note': note,
    'date': date,
    'colors': colors,
    'isCompleted': isCompleted,
  };
}
