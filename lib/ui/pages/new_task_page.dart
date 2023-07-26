import 'package:flutter/material.dart';
import 'package:progress_pal/ui/pages/add_new_task_page.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle')),
                    Expanded(
                        child: TaskSummaryCard(number: 1, tittle: 'tittle'))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return const TaskListTile(
                          chipBackgroundColor: Colors.cyan,
                        );
                      },
                      itemCount: 10),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(10, 188, 102, 1),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewTaskPage()));  
        },
        //mini: true,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
