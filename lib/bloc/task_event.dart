import 'package:equatable/equatable.dart';

import '../models/task_model.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  AddTask(this.task);

  @override
  List<Object> get props => [task];
}
