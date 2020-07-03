import 'package:todolist/Model/todomodel.dart';

class Storage {
  static final Storage _singleton = Storage._internal();
  factory Storage() => _singleton;
  Storage._internal();
  static Storage get shared => _singleton;

  List<ToDoModel> _todoList = new List();
  int initialId = 1;

  void add(ToDoModel list){
    int _lastId;
    int _futureId;

    if(_todoList != null){
      if(list.id == null){ // INSERT
        List<ToDoModel> sorting = Storage.shared.fetchAll();

        if(sorting.length > 0) { // IF '_todoList' contain list of data, THEN insert 
          sorting.sort((a, b) => a.id.compareTo(b.id));
          _lastId = sorting.last.id;
          _futureId = _lastId + 1;
          _todoList.add(new ToDoModel(_futureId, list.todoTitle, list.startDate, list.endDate, list.isCompleted));
        } else { // ELSE fresh insert
          _todoList.add(new ToDoModel(initialId, list.todoTitle, list.startDate, list.endDate, list.isCompleted));
        }
      } else { // UPDATE
        for(var i = 0; i < _todoList.length; i++){
          if(_todoList[i].id == list.id){ // IF Id is found, THEN update
            _todoList[i].todoTitle = list.todoTitle;
            _todoList[i].startDate = list.startDate;
            _todoList[i].endDate = list.endDate;
            _todoList[i].isCompleted = list.isCompleted;
          } 
        }
      }
    }
  }

  ToDoModel fetchById(int id){
    ToDoModel temp;
    _todoList.forEach((item) => {
      if(item.id == id){
        temp = item
      }
    });
    return temp;
  }

  List<ToDoModel> fetchAll(){
    return _todoList;
  }

}