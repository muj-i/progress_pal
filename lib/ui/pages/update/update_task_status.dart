import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

class UpdateTaskStatusBottomSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusBottomSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusBottomSheet> createState() =>
      _UpdateTaskStatusBottomSheetState();
}

class _UpdateTaskStatusBottomSheetState
    extends State<UpdateTaskStatusBottomSheet> {
  List<String> taskStatusList = [
    "New",
    "In Progress",
    "Completed",
    "Cancelled"
  ];
  late String _selectedTask;
  bool updateTaskInProgress = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.updateTasksStatus(taskId, newStatus));
    updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      widget.onUpdate();
      if (mounted) {
        Get.back();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Update task status has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: ScreenBackground(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Text(
                      'Update Status',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: taskStatusList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        _selectedTask = taskStatusList[index];
                        setState(() {});
                      },
                      title: Text(
                        taskStatusList[index].toUpperCase(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      trailing: _selectedTask.toLowerCase() ==
                              taskStatusList[index].toLowerCase()
                          ? const Icon(
                              Icons.radio_button_checked_rounded,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.radio_button_off_rounded,
                              color: Colors.white,
                            ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Visibility(
                visible: updateTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      updateTask(widget.task.sId!, _selectedTask);
                      Get.back();
                    },
                    child: const Text('Update Task Status'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
