import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.taskName,
    this.isCompleted = false,
    required this.index,
    required this.onTap,
    required this.onDelete,
  });

  final int index;
  final String taskName;
  final bool isCompleted;
  final Function(int) onTap;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                taskName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            _taskState(),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                onDelete(index);
              },
              child: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskState() {
    return Icon(
      isCompleted ? Icons.check : Icons.close,
      color: isCompleted ? Colors.green : Colors.red,
      size: 24,
    );
  }
}
