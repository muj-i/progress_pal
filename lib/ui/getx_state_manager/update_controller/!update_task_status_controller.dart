// ignore_for_file: file_names
// import 'package:get/get.dart';
// import 'package:progress_pal/data/model/network_response.dart';
// import 'package:progress_pal/data/services/network_caller.dart';
// import 'package:progress_pal/data/utils/urls.dart';

// class UpdateTaskStatusController extends GetxController {
//   List<String> taskStatusList = [
//     "New",
//     "In Progress",
//     "Completed",
//     "Cancelled"
//   ];
//   late String _selectedTask;

//   // Constructor to accept the selected task status
//   UpdateTaskStatusController(String initialSelectedTask) {
//     _selectedTask = initialSelectedTask;
//   }
//   bool updateTaskInProgress = false;

//   @override
//   void onInit() {
//    // _selectedTask = widget.task.status ?? '';// Initialize _selectedTask as needed
//     super.onInit();
//   }

//   String get selectedTask => _selectedTask; // Getter for _selectedTask

//   void setSelectedTask(String task) {
//   _selectedTask = task;
//   print('Selected Task: $_selectedTask'); // Add this line
//   update(); // Notify listeners of the change
// }


//   Future<void> updateTask(String taskId) async {
//     updateTaskInProgress = true;
//     update();
    
//     final NetworkResponse response = await NetworkCaller()
//         .getRequest(Urls.updateTasksStatus(taskId, _selectedTask));
    
//     updateTaskInProgress = false;
//     update();

//     if (response.isSuccess) {
//       //taskList[index].status = _selectedTask;

//   update();
//       // Perform any necessary actions after successful update
//       Get.back();
//     } else {
//       // Handle update failure
//       Get.snackbar('Update Failed', 'Update task status has failed');
//     }
//   }
// }
