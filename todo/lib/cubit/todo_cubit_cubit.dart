import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';

part 'todo_cubit_state.dart';

class TodoCubitCubit extends Cubit<TodoCubitState> {
  List<Todo> _todos = [];
  TodoCubitCubit() : super(TodoCubitState(todos: []));
  void add(Todo todo) {
    _todos = List.from(_todos);
    _todos.add(todo);
    filter(state.status);
  }

  void delete(Todo todo) {
    _todos = List.from(_todos);
    _todos.remove(todo);
    filter(state.status);
  }

  void update(Todo todo) {
    _todos = List.from(_todos);
    _todos =
        _todos.map((e) {
          if (e.id == todo.id) {
            return todo;
          }
          return e;
        }).toList();
    filter(state.status);
  }

  

  void filter(status) {
    if (status == TodoStatus.pending) {
      List<Todo> todos = List.from(_todos);
      List<Todo> newTodos = todos.where((e) => !e.isCompleted).toList();
      emit(TodoCubitState(todos: newTodos, status: status));
    } else {
      List<Todo> todos = List.from(_todos);

      List<Todo> newTodos = todos.where((e) => e.isCompleted).toList();

      emit(TodoCubitState(todos: newTodos, status: status));
    }
  }
}

enum TodoStatus { pending, completed }
