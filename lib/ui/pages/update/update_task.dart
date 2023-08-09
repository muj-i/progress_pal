import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class UpdateTaskBottomSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;
  final VoidCallback onTaskAdded;
  const UpdateTaskBottomSheet(
      {super.key,
      required this.task,
      required this.onUpdate,
      required this.onTaskAdded});

  @override
  State<UpdateTaskBottomSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _tittleController;
  late TextEditingController _descriptionController;
  bool _updateTaskInProgress = false, _addNewTaskInProgress = false;
  TasksListModel _tasksListModel = TasksListModel();

  @override
  void initState() {
    _tittleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  /**
  // ! this method will work when the update task api is available
  // Future<void> updateTask(String taskId) async {
  //   _updateTaskInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   Map<String, dynamic> requestBody = {
  //     "title": _tittleController.text.trim(),
  //     "description": _descriptionController.text.trim(),
  //   };
  //   final NetworkResponse response = await NetworkCaller()
  //       .postRequest(Urls.updateListTasks(taskId), requestBody);
  //   _updateTaskInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   if (response.isSuccess) {
  //     _tittleController.clear();
  //     _descriptionController.clear();
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Task updated successfully')));
  //     }
  //     widget.onUpdate();
  //   } else {
  //     if (mounted) {
  //       customDialogBox.show(
  //           context: context,
  //           contentMessage:
  //               'Task update failed!\nCurrently Task update API is not available',
  //           buttonText: 'Close',
  //           onButtonPressed: () {
  //             Navigator.pop(context);
  //           });
  //     }
  //   }
  // }
  */
  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteListTasks(taskId));
    if (response.isSuccess) {
      _tasksListModel.data?.removeWhere((element) => element.sId == taskId);

      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Tasks cannot be deleted');
      }
    }
  }

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _tittleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": widget.task.status
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Task successfully updated');

        widget.onTaskAdded();
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Task cannot be updated');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ScreenBackground(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Update task',
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            size: 32,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _tittleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Tittle',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Task must need a tittle";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 10,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _updateTaskInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: Visibility(
                          visible: _addNewTaskInProgress == false,
                          replacement:
                              Center(child: const CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: () {
                                deleteTask(widget.task.sId!);
                                addNewTask();
                                // ! this method will work when the update task api is available
                                // updateTask(widget.task.sId!);
                              },
                              child: const Text('Update')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
