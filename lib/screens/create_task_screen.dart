// screens/create_task_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/bloc/task_bloc.dart';
import 'package:task_assignment/bloc/task_event.dart';
import 'package:task_assignment/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  String? _selectedEmployee;
  final List<String> _employees = [
    'Muthuvel',
    'Gokul',
    'Shiva',
    'Selva',
    'Priya'
  ]; // Dummy data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create Task',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, // Center the title text
          backgroundColor: Colors.blueAccent, // Change the background color
          elevation: 4.0, // Adds a shadow below the app bar for depth
          shadowColor: Colors.grey[400], // Shadow color under the app bar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(
                  context); // Functionality to return to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Add form key to manage validation
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Name Input
                    TextFormField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                        filled: true,
                        // fillColor: Colors.grey[100],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Task Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Task Description Input
                    TextFormField(
                      controller: _taskDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Task Description',
                        labelStyle:
                            TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                        filled: true,
                        // fillColor: Colors.grey[100],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Dropdown for Employee Assignment
                    DropdownButtonFormField<String>(
                      value: _selectedEmployee,
                      hint: const Text('Assign to Employee'),
                      decoration: InputDecoration(
                        filled: true,
                        // fillColor: Colors.grey[100],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 2.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                      ),
                      items: _employees.map((String employee) {
                        return DropdownMenuItem<String>(
                          value: employee,
                          child: Text(employee),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEmployee = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please assign the task to an employee';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Add Task Button with validation
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newTask = Task(
                        taskName: _taskNameController.text,
                        taskDescription: _taskDescriptionController.text,
                        assignedEmployee: _selectedEmployee!,
                      );
                      BlocProvider.of<TaskBloc>(context).add(AddTask(newTask));
                      Navigator.pop(
                          context); // Return to task list after creation
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
