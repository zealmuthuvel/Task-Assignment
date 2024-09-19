// bloc/task_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../models/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) {
      if (state is TaskLoaded) {
        final updatedTasks = List<Task>.from((state as TaskLoaded).tasks)
          ..add(event.task);
        emit(TaskLoaded(updatedTasks));
      } else {
        emit(TaskLoaded([event.task]));
      }
    });
  }
}
