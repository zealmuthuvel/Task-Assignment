import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/bloc/task_bloc.dart';
import 'package:task_assignment/bloc/task_state.dart';

import 'create_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Change the background color
        elevation: 4.0, // Adds a shadow below the app bar for depth
        shadowColor: Colors.grey[400], // Shadow color under the app bar

        flexibleSpace: Container(),
        title: const Text(
          'Task List',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color:
                    Colors.blueAccent, // Background color for the icon button
                shape: BoxShape.circle, // Makes the container circular
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Adds shadow effect
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.add),
                iconSize: 28.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CreateTaskScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];

                // Using different colors based on even/odd index for variety
                final tileColor =
                    index % 2 == 0 ? Colors.blue[50] : Colors.green[50];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 3), // Shadow position
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(
                        task.taskName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      subtitle: Text(
                        '${task.taskDescription} - ${task.assignedEmployee}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          task.taskName[0], // First letter of the task name
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
              child: Text(
            'No tasks available',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ));
        },
      ),
    );
  }
}
