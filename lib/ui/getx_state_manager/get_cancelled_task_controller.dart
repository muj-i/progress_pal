import 'package:get/get.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';

class GetCancelledTaskController extends GetxController {
  bool _getCancelledTasksInProgress = false;
  bool get getCancelledTasksInProgress => _getCancelledTasksInProgress;
  TasksListModel _tasksListModel = TasksListModel();

  TasksListModel get getTasksListModel => _tasksListModel;
  Future<bool> getCancelledTask() async {
    _getCancelledTasksInProgress = true;

    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.cancelListTasks);
    _getCancelledTasksInProgress = false;

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
