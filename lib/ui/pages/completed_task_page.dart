import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/getx_state_manager/get_completed_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';
import 'package:progress_pal/ui/pages/update/update_task.dart';
import 'package:progress_pal/ui/pages/update/update_task_status.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/dialog_box.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final GetCompletedTaskController _getCompletedTaskController =
      Get.find<GetCompletedTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getSummaryCount();
      _getCompletedTaskController.getCompleteTask();
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteListTasks(taskId));
    if (response.isSuccess) {
      final TaskData taskToDelete =
          _getCompletedTaskController.getTasksListModel.data!.firstWhere(
        (task) => task.sId == taskId,
        orElse: () => TaskData(category: 'Default'),
      );
      final String category = taskToDelete.status ?? 'Default';

      _getCompletedTaskController.getTasksListModel.data!
          .removeWhere((element) => element.sId == taskId);

      // Update the summary count
      final Map<String, int> categoryCount = {};
      for (var task in _getCompletedTaskController.getTasksListModel.data!) {
        final category = task.status ?? 'Default';
        categoryCount[category] = (categoryCount[category] ?? 0) + 1;
      }

      for (var countModel
          in _summaryCountController.getSummaryCountModel.data!) {
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
    _summaryCountController.sortSummaryData();
    return Scaffold(
      body: ScreenBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            _getCompletedTaskController.getCompleteTask();
            _summaryCountController.sortSummaryData();
            _summaryCountController.getSummaryCount();
          },
          child: SafeArea(
            child: Column(
              children: [
                GetBuilder<SummaryCountController>(builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: _summaryCountController.getSummaryCountInProgress
                        ? const LinearProgressIndicator()
                        : SizedBox(
                            height: 86,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final reversedIndex = _summaryCountController
                                        .getSummaryCountModel.data!.length -
                                    1 -
                                    index;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 4.5),
                                    child: SizedBox(
                                      width: 93,
                                      child: TaskSummaryCard(
                                          tittle: _summaryCountController
                                                  .getSummaryCountModel
                                                  .data![reversedIndex]
                                                  .sId ??
                                              'New',
                                          number: _summaryCountController
                                                  .getSummaryCountModel
                                                  .data![reversedIndex]
                                                  .sum ??
                                              0),
                                    ));
                              },
                              itemCount: _summaryCountController
                                      .getSummaryCountModel.data?.length ??
                                  0,
                            ),
                          ),
                  );
                }),
                GetBuilder<GetCompletedTaskController>(builder: (_) {
                  return Expanded(
                    child: _getCompletedTaskController
                            .getCompletedTasksInProgress
                        ? const Center(child: RefreshProgressIndicator())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final reversedIndex = _getCompletedTaskController
                                      .getTasksListModel.data!.length -
                                  1 -
                                  index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: TaskListTile(
                                  chipBackgroundColor: Colors.green.shade600,
                                  data: _getCompletedTaskController
                                      .getTasksListModel.data![reversedIndex],
                                  onDeletePress: () {
                                    DialogBox.show(
                                      context: context,
                                      contentMessage:
                                          'Do you want to delete the task?',
                                      leftButtonText: 'Cancel',
                                      rightButtonText: 'Delete',
                                      onLeftButtonPressed: () {
                                        Get.back();
                                      },
                                      onRightButtonPressed: () {
                                        deleteTask(_getCompletedTaskController
                                            .getTasksListModel
                                            .data![reversedIndex]
                                            .sId!);
                                        Get.back();
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
                                        _getCompletedTaskController
                                            .getTasksListModel
                                            .data![reversedIndex]);
                                  },
                                  onStatusChipPress: () {
                                    showStatusUpdateBottomSheet(
                                        _getCompletedTaskController
                                            .getTasksListModel
                                            .data![reversedIndex]);
                                  },
                                ),
                              );
                            },
                            itemCount: _getCompletedTaskController
                                    .getTasksListModel.data?.length ??
                                0,
                          ),
                  );
                }),
              ],
            ),
          ),
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
            _getCompletedTaskController.getCompleteTask();
          },
          onTaskAdded: () {
            _getCompletedTaskController.getCompleteTask();
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
              _getCompletedTaskController.getCompleteTask();
              _summaryCountController.getSummaryCount();
            },
          );
        });
  }
}
