import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskListTile extends StatelessWidget {
  final Color chipBackgroundColor;

  const TaskListTile({super.key, required this.chipBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: const Text('Tittle Placeholder'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Subtittle Placeholder'),
            const SizedBox(
              height: 8,
            ),
            const Text('Date Placeholder'),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: Text(
                      'NEW',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                  backgroundColor: chipBackgroundColor,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.penToSquare,
                    color: Colors.green,
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
