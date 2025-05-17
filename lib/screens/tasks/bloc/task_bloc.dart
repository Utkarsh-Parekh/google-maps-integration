import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_event.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_state.dart';
import 'package:demaze_practical/screens/tasks/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TaskBloc() : super(TaskState()) {
    on<AddTask>(_addTask);
    on<UpdateTask>(_updateTask);
    on<DeleteTask>(_deleteTask);
    on<FetchTasks>(_fetchTasks);
  }

  Future<void> _addTask(AddTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    await firestore
        .collection('Tasks')
        .doc(event.task.id)
        .set(event.task.toMap());
    add(FetchTasks());
  }

  Future<void> _updateTask(UpdateTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    await firestore
        .collection('Tasks')
        .doc(event.task.id)
        .update(event.task.toMap());
    add(FetchTasks());
  }

  Future<void> _deleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    await firestore.collection('Tasks').doc(event.taskId).delete();
    add(FetchTasks());
  }

  Future<void> _fetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final querySnapshot = await firestore.collection('Tasks').get();
      final tasks = querySnapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data()))
          .toList();
      emit(state.copyWith(tasks: tasks, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: "Failed to fetch tasks", isLoading: false));
    }
  }
}
