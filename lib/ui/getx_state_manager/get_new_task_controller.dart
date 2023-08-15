import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class GetNewTaskController extends GetxController {
  bool _getNewTasksInProgress = false;
  bool get getNewTasksInProgress => _getNewTasksInProgress;
  TasksListModel _tasksListModel = TasksListModel();

  TasksListModel get getTasksListModel => _tasksListModel;

  Future<bool> getNewTask() async {
    _getNewTasksInProgress = true;

    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.newListTasks);
    _getNewTasksInProgress = false;

    if (response.isSuccess) {
      _tasksListModel = TasksListModel.fromJson(response.body!);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
