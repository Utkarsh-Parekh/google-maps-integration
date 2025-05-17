import 'package:demaze_practical/screens/tasks/model/task_model.dart';

abstract class TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;

  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskModel task;

  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);
}

class FetchTasks extends TaskEvent {}
