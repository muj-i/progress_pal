import 'package:flutter/material.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/services/network_caller.dart';
import 'package:progress_pal/data/utils/urls.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';

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
  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _tittleEditingController.text.trim(),
      "description": _descriptionEditingController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        CustomSnackbar.show(
            context: context, message: 'Task successfully added');

        // widget.onTaskAdded();
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        CustomSnackbar.show(context: context, message: 'Task cannot be added');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        tittle: 'Add New Task',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      body: ScreenBackground(
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
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        addNewTask().then((value) {
                          widget.getNewTask();
                          widget.getSummaryCount();
                        });
                      },
                      child: Text('Save Task', style: myButtonTextColor),
                    ),
                  ),
                ),
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
