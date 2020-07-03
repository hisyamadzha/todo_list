class ToDoModel {
  int id;
  String todoTitle;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;
  static ToDoModel _toDoModel;

  ToDoModel(
    this.id,
    this.todoTitle, 
    this.startDate, 
    this.endDate, 
    this.isCompleted
  );

  static ToDoModel getToDo(){
    return _toDoModel;
  }

  static void setToDo(ToDoModel toDoModel){
    _toDoModel = toDoModel;
  }

  static void clear(){
    _toDoModel = null;
  }

}

