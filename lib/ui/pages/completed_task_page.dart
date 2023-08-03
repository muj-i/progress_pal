import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/summary_count_model.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/profile_app_bar.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({super.key});

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  bool _getSummaryCountInProgress = false, _getCompleteTasksInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TasksListModel _tasksListModel = TasksListModel();

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSummaryCount();
      getCompleteTask();
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

  Future<void> getCompleteTask() async {
    _getCompleteTasksInProgress = true;

    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completeListTasks);
    if (response.isSuccess) {
      _tasksListModel = TasksListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Tasks cannot be loaded');
      }
    }
    _getCompleteTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                child: _getSummaryCountInProgress
                    ? LinearProgressIndicator()
                    : Row(
                  children: [
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle'))
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
               child: _getCompleteTasksInProgress
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final reversedIndex =
                              _tasksListModel.data!.length - 1 - index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                            child: TaskListTile(
                              chipBackgroundColor: Colors.green.shade600,
                              data: _tasksListModel.data![reversedIndex],
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
    );
  }
}
