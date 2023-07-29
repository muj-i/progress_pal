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
        color: Colors.white70,
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
