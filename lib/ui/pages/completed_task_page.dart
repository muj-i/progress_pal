import 'package:flutter/material.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class CompletedTaskPage extends StatelessWidget {
  const CompletedTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  HomeAppBar(myIconButton: IconButton(onPressed: (){// todo log out
      }, icon: Icon(Icons.logout_rounded)),),
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
                          chipBackgroundColor: Color.fromRGBO(10, 188, 102, 1),
                        );
                      },
                      itemCount: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
