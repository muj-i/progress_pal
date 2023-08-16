import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class GetCompletedTaskController extends GetxController {
  bool _getCompletedTasksInProgress = false;
  bool get getCompletedTasksInProgress => _getCompletedTasksInProgress;
  TasksListModel _tasksListModel = TasksListModel();

  TasksListModel get getTasksListModel => _tasksListModel;
  Future<bool> getCompleteTask() async {
    _getCompletedTasksInProgress = true;

    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.completeListTasks);
    _getCompletedTasksInProgress = false;

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
