import 'package:flutter/material.dart';

class TaskSummaryCard extends StatelessWidget {
  final int number;
  final String tittle;

  const TaskSummaryCard(
      {super.key, required this.number, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(tittle)
          ],
        ),
      ),
    );
  }
}
