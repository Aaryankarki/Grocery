part of 'todo_cubit_cubit.dart';

class TodoCubitState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;

  TodoCubitState({required this.todos, this.status= TodoStatus.pending});


  @override
  List<Object> get props => [todos,status];
}

