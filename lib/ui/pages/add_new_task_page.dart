import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_pal/ui/getx_state_manager/add_new_task_controller.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_backgrounds.dart';

class AddNewTaskPage extends StatefulWidget {
  final Function() getNewTask;
  final Function() getSummaryCount;
  const AddNewTaskPage(
      {super.key, required this.getNewTask, required this.getSummaryCount});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tittleEditingController =
      TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        tittle: 'Add New Task',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      body: InsideScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _tittleEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Tittle',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return "Task must need a tittle";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _descriptionEditingController,
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                GetBuilder<AddNewTaskController>(
                    builder: (addNewTaskController) {
                  return SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible:
                          addNewTaskController.addNewTaskInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          addNewTaskController
                              .addNewTask(_tittleEditingController.text.trim(),
                                  _descriptionEditingController.text.trim())
                              .then((addedTask) {
                            if (addedTask == true) {
                              CustomSnackbar.show(
                                  context: context,
                                  message: 'Task added successful');
                              Get.back();
                              widget.getNewTask();
                              widget.getSummaryCount();
                            } else {
                              CustomSnackbar.show(
                                  context: context,
                                  message: 'Task added failed');
                            }
                          });
                        },
                        child: Text('Save Task', style: myButtonTextColor),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
