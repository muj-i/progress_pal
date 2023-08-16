// ignore_for_file: file_names
// import 'package:get/get.dart';
// import 'package:progress_pal/data/model/network_response.dart';
// import 'package:progress_pal/data/model/tasks_list_model.dart';
// import 'package:progress_pal/data/services/network_caller.dart';
// import 'package:progress_pal/data/utils/urls.dart';
// import 'package:progress_pal/ui/getx_state_manager/get_new_task_controller.dart';
// import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';

// class DeleteTaskController extends GetxController {
//   final TasksListModel _tasksListModel = TasksListModel();
//   TasksListModel get getTasksListModel => _tasksListModel;
//  final SummaryCountController _summaryCountController =
//       Get.find<SummaryCountController>();
//       final GetNewTaskController _getNewTaskController =
//       Get.find<GetNewTaskController>();
//   Future<bool> deleteTask(String taskId) async {
//     final NetworkResponse response =
//         await NetworkCaller().getRequest(Urls.deleteListTasks(taskId));
//     if (response.isSuccess) {
//       final TaskData? taskToDelete = _tasksListModel.data?.firstWhere(
//         (task) => task.sId == taskId,
//         orElse: () => TaskData(category: 'Default'),
//       );
//       final String category = taskToDelete?.status ?? 'Default';

//       _tasksListModel.data?.removeWhere((element) => element.sId == taskId);

//       final Map<String, int> categoryCount = {};
//       for (var task in _tasksListModel.data ?? []) {
//         final category = task.status ?? 'Default';
//         categoryCount[category] = (categoryCount[category] ?? 0) + 1;
//       }

//       for (var countModel
//           in _summaryCountController.getSummaryCountModel.data!) {
//         if (countModel.sId == category) {
//           countModel.sum = categoryCount[category] ?? 0;
//         }
//       }
// _getNewTaskController.getNewTask();
//     _summaryCountController.getSummaryCount();
//       update();
//       return true;
//     } else {
//        update();
//       return true;
//       // if (mounted) {
//       //   CustomSnackbar.show(
//       //       context: context, message: 'Tasks cannot be deleted');
//       // }
//     }
//   }
// }
