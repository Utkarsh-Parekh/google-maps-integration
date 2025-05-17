import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_bloc.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_event.dart';
import 'package:demaze_practical/screens/tasks/bloc/task_state.dart';
import 'package:demaze_practical/screens/tasks/constants/tasks_constants.dart';
import 'package:demaze_practical/screens/tasks/model/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context);
    final CollectionReference note =
        FirebaseFirestore.instance.collection("Tasks");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(TaskConstants.todoHeader),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return StreamBuilder(
              stream: note
                  .where('creator',
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.size == 0) {
                  return Center(
                    child: Lottie.asset(
                      "lib/assets/no_tasks.json",
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      final task = snapshot.data?.docs[index];
                      final todos = state.tasks[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListTile(
                          title: Text(
                            task!['title'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(task['description'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () =>
                                    _showTaskDialog(context, todos, true),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  taskBloc.add(DeleteTask(task.id));
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(context, null, false),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTaskDialog(BuildContext context, TaskModel? task, bool isUpdate) {
    final titleController = TextEditingController(text: task?.title);
    final descriptionController =
        TextEditingController(text: task?.description);
    final taskBloc = BlocProvider.of<TaskBloc>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text(isUpdate ? TaskConstants.UpdateTask : TaskConstants.addTask),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(labelText: TaskConstants.titleLabel),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  labelText: TaskConstants.descriptionLabel),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text(TaskConstants.cancelLabel),
          ),
          ElevatedButton(
            onPressed: () {
              if (isUpdate) {
                taskBloc.add(UpdateTask(
                  task!.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                  ),
                ));
              } else {
                final newTask = TaskModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    description: descriptionController.text,
                    creator: FirebaseAuth.instance.currentUser!.uid);

                taskBloc.add(AddTask(newTask));
              }
              context.pop();
            },
            child: Text(isUpdate
                ? TaskConstants.UpdateButtonText
                : TaskConstants.addbuttonText),
          ),
        ],
      ),
    );
  }
}
