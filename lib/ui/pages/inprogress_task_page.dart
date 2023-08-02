import 'package:flutter/material.dart';

import 'package:progress_pal/ui/widgets/profile_app_bar.dart';
import 'package:progress_pal/ui/widgets/sceen_background.dart';
import 'package:progress_pal/ui/widgets/task_list_tile.dart';
import 'package:progress_pal/ui/widgets/task_summary_card.dart';

class InProgressTaskPage extends StatelessWidget {
  const InProgressTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
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
                        // return  TaskListTile(
                        //   chipBackgroundColor: Colors.purple, data: ,
                        // );
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
