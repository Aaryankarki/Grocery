import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit_cubit.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/pages/show_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              onTap:
                  (index) => context.read<TodoCubitCubit>().filter(
                    TodoStatus.values[index],
                  ),
              tabs: [
                Tab(child: Text("pending")),
                Tab(child: Text("Completed")),
              ],
            ),
          ),
        ),
        body: BlocBuilder<TodoCubitCubit, TodoCubitState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final Todo todo = state.todos[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: Card(
                    color: const Color.fromARGB(255, 219, 187, 187),
                    child: ListTile(
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: todo.isCompleted,
                            onChanged: (isCompleted) {
                              context.read<TodoCubitCubit>().update(
                                todo.copyWith(isCompleted: isCompleted),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<TodoCubitCubit>().delete(todo);
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showDialog,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return TodoDialogPage();
      },
    );
  }
}
