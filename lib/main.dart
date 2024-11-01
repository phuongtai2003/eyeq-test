import 'package:flutter/material.dart';
import 'package:todo_list/task.dart';
import 'package:todo_list/task_list_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Task> _taskList = <Task>[];

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _taskNameController,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Please enter a task name";
                      } else if (name.length <= 6) {
                        return "Task name not long enough";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _onAddTask,
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onAddTask() {
    if (_formKey.currentState?.validate() ?? false) {
      _taskList.add(
        Task(name: _taskNameController.text, isCompleted: false),
      );
      _taskNameController.clear();
      setState(() {});

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo List App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          final taskItem = _taskList[index];
          return TaskListItem(
            key: UniqueKey(),
            index: index,
            taskName: taskItem.name,
            isCompleted: taskItem.isCompleted,
            onDelete: (idx) {
              _taskList.removeAt(idx);
              setState(() {});
            },
            onTap: (idx) {
              _taskList[idx] =
                  taskItem.copyWith(isCompleted: !taskItem.isCompleted);
              setState(() {});
            },
          );
        },
        itemCount: _taskList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
