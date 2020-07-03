import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Model/todomodel.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Services/Routes/router.gr.dart';
import 'package:todolist/Services/Storage/storage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  bool checkBoxValue = true;
  List<ToDoModel> todoList = new List();

  @override
  void initState() {
    super.initState();
    todoList = Storage.shared.fetchAll();
  }

  void onUpdateToDo(ToDoModel toDoModel) {
    ToDoModel.setToDo(Storage.shared.fetchById(toDoModel.id));
    ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.addToDo);
  }

  void onUpdateStatus(ToDoModel toDoModel, bool status) {
    Storage.shared.add(new ToDoModel(toDoModel.id, toDoModel.todoTitle, toDoModel.startDate, toDoModel.endDate, status));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(   
        title: Text(
          "To-Do List",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildPortraitLayout();
          } else {
            return _buildPortraitLayout();
          }
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              ToDoModel.clear();
              ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.addToDo);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildPortraitLayout() {
    
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      onUpdateToDo(todoList[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                          maxHeight: 200
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18.0)
                                ),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(
                                        todoList[index].todoTitle,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: const Text(
                                                'Start Date',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: const Text(
                                                'End Date',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: const Text(
                                                'Time Left',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                new DateFormat('dd MMM yyyy').format(todoList[index].startDate),
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                new DateFormat('dd MMM yyyy').format(todoList[index].endDate),
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: AlignmentDirectional.topStart,
                                              child: Text(
                                                todoList[index].endDate.difference(DateTime.now()).inHours.toString() + " hrs " + todoList[index].endDate.difference(DateTime.now()).inMinutes.remainder(60).toString() + " min",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE1DCC8),
                                borderRadius: BorderRadius.only(
                                  bottomLeft:  Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Status',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                todoList[index].isCompleted ? 'Completed' : 'Incomplete',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                            ),
                                            flex: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: const Text(
                                                'Tick if completed'
                                              ),
                                            ),
                                            flex: 4,
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Checkbox(value: todoList[index].isCompleted,
                                                activeColor: Colors.amber,
                                                onChanged: (bool newValue) {
                                                  setState(() {
                                                    onUpdateStatus(todoList[index], newValue);
                                                  });
                                                },
                                              ),
                                            ),
                                            flex: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout() {

    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[300],
          child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity
          ),
        ),
      ),
    );
  }
}