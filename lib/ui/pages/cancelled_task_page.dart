import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/getx_state_manager/get_cancelled_task_controller.dart';
import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';
import 'package:progress_pal/ui/pages/update/update_task.dart';
import 'package:progress_pal/ui/pages/update/update_task_status.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/dialog_box.dart';
import 'package:progress_pal/ui/widgets/profile_app_bar.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class CancelledTaskPage extends StatefulWidget {
  const CancelledTaskPage({super.key});

  @override
  State<CancelledTaskPage> createState() => _CancelledTaskPageState();
}

class _CancelledTaskPageState extends State<CancelledTaskPage> {
  final SummaryCountController _summaryCountController =
      Get.find<SummaryCountController>();
  final GetCancelledTaskController _getCancelledTaskController =
      Get.find<GetCancelledTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _summaryCountController.getSummaryCount();
      _getCancelledTaskController.getCancelledTask();
    });
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.deleteListTasks(taskId));
    if (response.isSuccess) {
      final TaskData taskToDelete =
          _getCancelledTaskController.getTasksListModel.data!.firstWhere(
        (task) => task.sId == taskId,
        orElse: () => TaskData(category: 'Default'),
      );
      final String category = taskToDelete.status ?? 'Default';

      _getCancelledTaskController.getTasksListModel.data!
          .removeWhere((element) => element.sId == taskId);

      final Map<String, int> categoryCount = {};
      for (var task in _getCancelledTaskController.getTasksListModel.data!) {
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
      appBar: const ProfileAppBar(),
      body: ScreenBackground(
        child: RefreshIndicator(
          onRefresh: () async {
            _getCancelledTaskController.getCancelledTask();
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
                GetBuilder<GetCancelledTaskController>(builder: (_) {
                  return Expanded(
                    child: _getCancelledTaskController
                            .getCancelledTasksInProgress
                        ? const Center(child: RefreshProgressIndicator())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final reversedIndex = _getCancelledTaskController
                                      .getTasksListModel.data!.length -
                                  1 -
                                  index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                child: TaskListTile(
                                  chipBackgroundColor: Colors.red,
                                  data: _getCancelledTaskController
                                      .getTasksListModel.data![reversedIndex],
                                  onEditPress: () {
                                    showEditBottomSheet(
                                        _getCancelledTaskController
                                            .getTasksListModel
                                            .data![reversedIndex]);
                                  },
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
                                        deleteTask(_getCancelledTaskController
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
                                  onStatusChipPress: () {
                                    showStatusUpdateBottomSheet(
                                        _getCancelledTaskController
                                            .getTasksListModel
                                            .data![reversedIndex]);
                                  },
                                ),
                              );
                            },
                            itemCount: _getCancelledTaskController
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
            _getCancelledTaskController.getCancelledTask();
          },
          onTaskAdded: () {
            _getCancelledTaskController.getCancelledTask();
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
              _getCancelledTaskController.getCancelledTask();
              _summaryCountController.getSummaryCount();
            },
          );
        });
  }
}
