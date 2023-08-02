import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';

class TaskListTile extends StatelessWidget {
  final Color chipBackgroundColor;
  final TaskData data;

  const TaskListTile({super.key, required this.chipBackgroundColor, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title:  Text(data.title ?? 'No ittle found'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(data.description ?? 'No description found'),
            const SizedBox(
              height: 8,
            ),
             Text(data.createdDate ?? 'No added date found'),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Text(
                      data.status ?? 'New',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  backgroundColor: chipBackgroundColor,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('This is a SnackBar!'),
                    //     duration: Duration(
                    //         seconds:
                    //             2), // Duration for which the SnackBar is visible
                    //     action: SnackBarAction(
                    //       label: 'Dismiss',
                    //       onPressed: () {
                    //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    //       },
                    //     ),
                    //   ),
                    // );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.penToSquare,
                    color: Color.fromRGBO(10, 188, 102, 1),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.redAccent[200],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
