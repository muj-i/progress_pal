// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:progress_pal/data/model/network_response.dart';
// import 'package:progress_pal/data/model/tasks_list_model.dart';
// import 'package:progress_pal/data/services/network_caller.dart';
// import 'package:progress_pal/data/utils/urls.dart';
// import 'package:progress_pal/ui/getx_state_manager/get_new_task_controller.dart';
// import 'package:progress_pal/ui/getx_state_manager/summary_count_controller.dart';
// import 'package:progress_pal/ui/getx_state_manager/update_controller/update_task_status_controller.dart';
// import 'package:progress_pal/ui/widgets/sceen_background.dart';

// class UpdateTaskStatusBottomSheet extends StatefulWidget {
//   final TaskData task;
//   final VoidCallback onUpdate;
// final String initialTaskStatus;
//   const UpdateTaskStatusBottomSheet(
//       {Key? key, required this.task, required this.onUpdate, required this.initialTaskStatus})
//       : super(key: key);

//   @override
//   State<UpdateTaskStatusBottomSheet> createState() =>
//       _UpdateTaskStatusBottomSheetState();
// }

// class _UpdateTaskStatusBottomSheetState
//     extends State<UpdateTaskStatusBottomSheet> {
//     late UpdateTaskStatusController _updateTaskStatusController;
// final SummaryCountController _summaryCountController =
//       Get.find<SummaryCountController>();
//   final GetNewTaskController _getNewTaskController =
//       Get.find<GetNewTaskController>();

//   @override
//   void initState() {
//     _updateTaskStatusController =
//         UpdateTaskStatusController(widget.task.status ?? '');
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 400,
//       child: ScreenBackground(
//         child: Column(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     const Text(
//                       'Update Status',
//                       style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.close_rounded,
//                         size: 32,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                     )
//                   ],
//                 )),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: _updateTaskStatusController.taskStatusList.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       onTap: () {
//                        _updateTaskStatusController.setSelectedTask(_updateTaskStatusController.taskStatusList[index]);
//                       },
//                       title: Text(
//   _updateTaskStatusController.taskStatusList[index].toUpperCase(),
//   style: TextStyle(
//     color: _updateTaskStatusController.selectedTask ==
//             _updateTaskStatusController.taskStatusList[index]
//         ? Colors.white // Use white color for selected item
//         : Colors.white70, // Use a faded white color for other items
//     fontSize: 18,
//   ),
// ),
//                       trailing: _updateTaskStatusController.selectedTask ==
//                               _updateTaskStatusController.taskStatusList[index]
//                           ? const Icon(
//                               Icons.radio_button_checked_rounded,
//                               color: Colors.white,
//                             )
//                           : const Icon(
//                               Icons.radio_button_off_rounded,
//                               color: Colors.white,
//                             ),
//                     );
//                   }),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Visibility(
//                 visible: !_updateTaskStatusController.updateTaskInProgress,
//                 replacement: const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _updateTaskStatusController.updateTask(widget.task.sId!,);
//                       Get.back();
// _summaryCountController.getSummaryCount();
//       _getNewTaskController.getNewTask();
//                     },
//                     child: const Text('Update Task Status'),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
