import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/summary_count_model.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/pages/add_new_task_page.dart';
import 'package:progress_pal/ui/pages/update_task.dart';
import 'package:progress_pal/ui/pages/update_task_status.dart';
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
  bool _getSummaryCountInProgress = false, _getNewTasksInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TasksListModel _tasksListModel = TasksListModel();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSummaryCount();
      getNewTask();
    });
  }

  Future<void> getSummaryCount() async {
    _getSummaryCountInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.summaryCardCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Summary data cannot be loaded');
      }
    }
    _getSummaryCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTask() async {
    _getNewTasksInProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newListTasks);
    if (response.isSuccess) {
      _tasksListModel = TasksListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Tasks cannot be loaded');
      }
    }
    _getNewTasksInProgress = false;
    if (mounted) {
      setState(() {});
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
      _tasksListModel.data!.forEach((task) {
        final category = task.status ?? 'Default';
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      });

      _summaryCountModel.data!.forEach((countModel) {
        if (countModel.sId == category) {
          countModel.sum = categoryCount[category] ?? 0;
        }
      });

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
    return Scaffold(
      appBar: ProfileAppBar(),
      body: ScreenBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            getNewTask();
          },
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: _getSummaryCountInProgress
                      ? LinearProgressIndicator()
                      : SizedBox(
                          height: 86,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final reversedIndex =
                                  _summaryCountModel.data!.length - 1 - index;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 4.5),
                                  child: SizedBox(
                                    width: 93,
                                    child: TaskSummaryCard(
                                        tittle: _summaryCountModel
                                                .data![reversedIndex].sId ??
                                            'New',
                                        number: _summaryCountModel
                                                .data![reversedIndex].sum ??
                                            0),
                                  ));
                            },
                            itemCount: _summaryCountModel.data?.length ?? 0,
                          ),
                        ),
                ),
                Expanded(
                  child: _getNewTasksInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final reversedIndex =
                                _tasksListModel.data!.length - 1 - index;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              child: TaskListTile(
                                chipBackgroundColor: Colors.cyan,
                                data: _tasksListModel.data![reversedIndex],
                                onDeletePress: () {
                                  DialogBox.show(
                                    context: context,
                                    contentMessage: 'Wanna delete the task?',
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
                                  showEditBottomSheet(
                                      _tasksListModel.data![reversedIndex]);
                                },
                                onStatusChipPress: () {
                                  showStatusUpdateBottomSheet(
                                      _tasksListModel.data![reversedIndex]);
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
                      getSummaryCount: getSummaryCount)));
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
              getSummaryCount();
            },
          );
        });
  }
}
