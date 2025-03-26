import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit_cubit.dart';
import 'package:todo/model/todo.dart';

class TodoDialogPage extends StatefulWidget {
  const TodoDialogPage({super.key});

  @override
  State<TodoDialogPage> createState() => _TodoDialogPageState();
}

class _TodoDialogPageState extends State<TodoDialogPage> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleEditingController.dispose();
    _descriptionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add a todo"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleEditingController,
            decoration: InputDecoration(hintText: "title"),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _descriptionTextController,
            decoration: InputDecoration(hintText: "description"),
          ),
          SizedBox(height: 24),
          FilledButton(onPressed: _onAdd, child: Text("save")),
        ],
      ),
    );
  }

  void _onAdd() {
    final Todo todo = Todo(
      id: DateTime.now().toString(),
      title: _titleEditingController.text,
      description: _descriptionTextController.text,
    );

    context.read<TodoCubitCubit>().add(todo);
    Navigator.of(context).pop();
  }
}
