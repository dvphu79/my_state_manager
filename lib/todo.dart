// Define a Todo class to represent individual tasks
class Todo<T> {
  String title;
  bool completed;
  T? data;

  Todo({required this.title, this.completed = false, this.data});
}
