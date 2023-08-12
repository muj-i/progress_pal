import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_pal/data/model/tasks_list_model.dart';
import 'package:progress_pal/ui/widgets/constraints.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeletePress, onEditPress, onStatusChipPress;
  final Color chipBackgroundColor;
  final TaskData data;

  const TaskListTile(
      {super.key,
      required this.chipBackgroundColor,
      required this.data,
      required this.onDeletePress,
      required this.onEditPress,
      required this.onStatusChipPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(data.title ?? 'No ittle found'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.description ?? 'No description found'),
            const SizedBox(
              height: 8,
            ),
            Text('Created Date: ${data.createdDate ?? 'No added date found'}'),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onStatusChipPress,
                  child: Chip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 2),
                      child: Text(
                        data.status ?? 'New',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                    backgroundColor: chipBackgroundColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onEditPress,
                  icon: Icon(
                    FontAwesomeIcons.penToSquare,
                    color: myColor,
                  ),
                ),
                IconButton(
                  onPressed: onDeletePress,
                  icon: Icon(
                    FontAwesomeIcons.trash,
                    color: myColor,
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
