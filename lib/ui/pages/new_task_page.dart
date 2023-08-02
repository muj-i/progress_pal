import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/summary_count_model.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/pages/add_new_task_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
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
        await NetworkCaller().getRequest(Urls.listTask);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: _getSummaryCountInProgress
                      ? LinearProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                                child: TaskSummaryCard(
                                    number: 1, tittle: 'tittle')),
                            Expanded(
                                child: TaskSummaryCard(
                                    number: 1, tittle: 'tittle')),
                            Expanded(
                                child: TaskSummaryCard(
                                    number: 1, tittle: 'tittle')),
                            Expanded(
                                child: TaskSummaryCard(
                                    number: 1, tittle: 'tittle'))
                          ],
                        ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: _getNewTasksInProgress
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            final reversedIndex = _tasksListModel.data!.length - 1 - index;
                            return TaskListTile(
                              chipBackgroundColor: Colors.cyan,
                              data: _tasksListModel.data![reversedIndex],
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
}
