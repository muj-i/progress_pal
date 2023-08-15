import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';
import 'package:progress_pal/ui/pages/add_new_task_page.dart';
import 'package:progress_pal/ui/pages/update/update_task.dart';
import 'package:progress_pal/ui/pages/update/update_task_status.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/dialog_box.dart';
import 'package:progress_pal/ui/widgets/profile_app_bar.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  bool _getNewTasksInProgress = false, _delayInProgress = false;
  //final SummaryCountModel _summaryCountModel = SummaryCountModel();
  TasksListModel _tasksListModel = TasksListModel();
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();

  void sortSummaryData() {
    _summaryCountController.getSummaryCountModel.data?.sort((a, b) {
      final aId = a.sId ?? '';
      final bId = b.sId ?? '';
      return aId.compareTo(bId);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startDelay();
    });
  }

  Future<void> _startDelay() async {
    setState(() {
      _delayInProgress = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _delayInProgress = false;
    });

    _summaryCountController.getSummaryCount();
    getNewTask();
    const ProfileAppBar();
  }

  Future<void> getNewTask() async {
    _getNewTasksInProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newListTasks);
    _getNewTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _tasksListModel = TasksListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Tasks cannot be loaded');
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteListTasks(taskId));
    if (response.isSuccess) {
      final TaskData taskToDelete = _tasksListModel.data!.firstWhere(
        (task) => task.sId == taskId,
        orElse: () => TaskData(category: 'Default'),
      );
      final String category = taskToDelete.status ?? 'Default';

      _tasksListModel.data!.removeWhere((element) => element.sId == taskId);

      final Map<String, int> categoryCount = {};
      for (var task in _tasksListModel.data!) {
        final category = task.status ?? 'Default';
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      }

      for (var countModel in _summaryCountController.getSummaryCountModel.data!) {
        if (countModel.sId == category) {
          countModel.sum = categoryCount[category] ?? 0;
        }
      }

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

  @override
  Widget build(BuildContext context) {
    sortSummaryData();
    return Scaffold(
      appBar: const ProfileAppBar(),
      body: ScreenBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            getNewTask();
           _summaryCountController. getSummaryCount();
          },
          child: SafeArea(
            child: _delayInProgress
                ? const Center(child: RefreshProgressIndicator())
                : Column(
                    children: [
                      GetBuilder<SummaryCountController>(
                        
                        builder: (summaryCountController) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: summaryCountController.getSummaryCountInProgress
                                ? const LinearProgressIndicator()
                                : SizedBox(
                                    height: 86,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final reversedIndex =
                                            _summaryCountController.getSummaryCountModel.data!.length -
                                                1 -
                                                index;
                                        return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 4.5),
                                            child: SizedBox(
                                              width: 93,
                                              child: TaskSummaryCard(
                                                  tittle: _summaryCountController.getSummaryCountModel
                                                          .data![reversedIndex]
                                                          .sId ??
                                                      'New',
                                                  number: _summaryCountController.getSummaryCountModel
                                                          .data![reversedIndex]
                                                          .sum ??
                                                      0),
                                            ));
                                      },
                                      itemCount:
                                          _summaryCountController.getSummaryCountModel.data?.length ?? 0,
                                    ),
                                  ),
                          );
                        }
                      ),
                      Expanded(
                        child: _getNewTasksInProgress
                            ? const Center(child: RefreshProgressIndicator())
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  final reversedIndex =
                                      _tasksListModel.data!.length - 1 - index;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 10),
                                    child: TaskListTile(
                                      chipBackgroundColor: Colors.cyan,
                                      data:
                                          _tasksListModel.data![reversedIndex],
                                      onDeletePress: () {
                                        DialogBox.show(
                                          context: context,
                                          contentMessage:
                                              'Do you want to delete the task?',
                                          leftButtonText: 'Cancel',
                                          rightButtonText: 'Delete',
                                          onLeftButtonPressed: () {
                                            Navigator.pop(context);
                                          },
                                          onRightButtonPressed: () {
                                            deleteTask(_tasksListModel
                                                .data![reversedIndex].sId!);
                                            Navigator.pop(context);
                                            if (mounted) {
                                              CustomSnackbar.show(
                                                  context: context,
                                                  message:
                                                      'Task successfully deleted');
                                            }
                                          },
                                        );
                                      },
                                      onEditPress: () {
                                        showEditBottomSheet(_tasksListModel
                                            .data![reversedIndex]);
                                      },
                                      onStatusChipPress: () {
                                        showStatusUpdateBottomSheet(
                                            _tasksListModel
                                                .data![reversedIndex]);
                                      },
                                    ),
                                  );
                                },
                                itemCount: _tasksListModel.data?.length ?? 0,
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNewTaskPage(
                      getNewTask: getNewTask,
                      getSummaryCount:  _summaryCountController.getSummaryCount)));
        },
        //mini: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskBottomSheet(
          task: task,
          onUpdate: () {
            getNewTask();
          },
          onTaskAdded: () {
            getNewTask();
          },
        );
      },
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return UpdateTaskStatusBottomSheet(
            task: task,
            onUpdate: () {
              getNewTask();
              _summaryCountController.getSummaryCount();
            },
          );
        });
  }
}
