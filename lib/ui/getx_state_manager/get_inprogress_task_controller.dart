import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class GetInprogressTaskController extends GetxController {
  bool _getInProgressTasksInProgress = false;
  bool get getInProgressTasksInProgress => _getInProgressTasksInProgress;
  TasksListModel _tasksListModel = TasksListModel();

  TasksListModel get getTasksListModel => _tasksListModel;
  Future<bool> getInProgressTask() async {
    _getInProgressTasksInProgress = true;

    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressListTasks);
    _getInProgressTasksInProgress = false;

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
