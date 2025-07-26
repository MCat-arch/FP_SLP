import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_model.dart';
import 'package:to_do/provider/todo_provider.dart';

final uuid = Uuid();

class Inputform extends StatefulWidget {
  const Inputform({super.key});

  @override
  State<Inputform> createState() => _InputformState();
}

class _InputformState extends State<Inputform> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isCompleted = false;

  DateTime _selectedDate = DateTime.now();
  final List<Color> _colorOptions = [Colors.blue, Colors.red, Colors.orange];
  int _selectedColorIndex = 0;

  String get formattedDate => DateFormat('EEE, d MMM ').format(_selectedDate);

  void onAdd() async {
    TodoModel newData = TodoModel(
      id: uuid.v4(),
      isCompleted: isCompleted,
      title: _titleController.text,
      note: _noteController.text,
      date: DateFormat('yyyy-MM-dd').format(_selectedDate),
      colors: _selectedColorIndex,
    );

    Provider.of<TodoProvider>(context, listen: false).addData(newData);

    Navigator.of(context).pop(true);
    // context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //add icon to close from the input form
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          toolbarHeight: 100,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Add',
                      style: TextStyle(
                        fontSize: 42,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: ' Todo',
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 48),
            ],
          ),
        ),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Note',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),

                    hintStyle: TextStyle(color: Colors.grey.shade600),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(height: 10),
                // Date Picker ListTile
                ListTile(
                  style: ListTileStyle.drawer,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Text(
                    formattedDate,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: TextButton.icon(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: const Color.fromARGB(255, 68, 68, 68),
                      size: 30,
                    ),
                    label: Text(''),
                  ),
                ),
                SizedBox(height: 10),

                // Start Time & End Time Row
                SizedBox(height: 30),

                SizedBox(height: 50),
                // Baris warna dan tombol Save responsif
                Row(
                  children: [
                    Row(
                      children: List.generate(_colorOptions.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedColorIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      _selectedColorIndex == index
                                          ? Colors.black
                                          : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: _colorOptions[index],
                                radius: 15,
                                child:
                                    _selectedColorIndex == index
                                        ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                        : null,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    // SizedBox(width: 16),
                    // Expanded(
                    //   child: ElevatedButton(
                    //     onPressed: onAdd,
                    //     child: Text('Save'),
                    //   ),
                    // ),
                  ],
                ),
                // ...existing code...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
