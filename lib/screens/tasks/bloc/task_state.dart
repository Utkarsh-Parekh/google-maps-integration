import 'package:demaze_practical/screens/tasks/model/task_model.dart';

class TaskState {
  final List<TaskModel> tasks;
  final bool isLoading;
  final String? error;

  TaskState({this.tasks = const [], this.isLoading = false, this.error});

  TaskState copyWith({List<TaskModel>? tasks, bool? isLoading, String? error}) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
