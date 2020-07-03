import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/Model/todomodel.dart';
import 'package:todolist/Services/Routes/router.gr.dart';
import 'package:todolist/Services/Storage/storage.dart';

class AddToDo extends StatefulWidget {
  AddToDo({Key key}) : super(key: key);

  @override
  AddToDoState createState() => AddToDoState();
}

class AddToDoState extends State<AddToDo> {

  final _todoTitleCtrl = TextEditingController();
  FocusNode _focusNode;
  DateTime _dateTimeStart;
  DateTime _dateTimeEnd;
  ToDoModel _toDoModel;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _toDoModel = ToDoModel.getToDo();

    if(_todoTitleCtrl.text == ''){
      _todoTitleCtrl.text = _toDoModel != null ? _toDoModel.todoTitle : '';
    }
    if(_dateTimeStart == null){
      _dateTimeStart = _toDoModel != null ? _toDoModel.startDate : null;
    }
    if(_dateTimeEnd == null){
      _dateTimeEnd = _toDoModel != null ? _toDoModel.endDate : null;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void addTodoList(){
    if(_toDoModel != null){
      Storage.shared.add(new ToDoModel(_toDoModel.id, _todoTitleCtrl.text, _dateTimeStart, _dateTimeEnd, false));
    } else {
      Storage.shared.add(new ToDoModel(null, _todoTitleCtrl.text, _dateTimeStart, _dateTimeEnd, false));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(   
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.navigate_before, color: Colors.black),
              onPressed: () { 
                ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.home);
              },
            );
          },
        ),
        title: Text(
          "Add new To-Do List",
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
    );
  }

  Widget _buildPortraitLayout() { 
    final maxLines = 6;
    
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _focusNode.unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "To-Do Title",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          alignment: Alignment.center,
                          height: maxLines * 24.0,
                          child: TextField(
                            controller: _todoTitleCtrl,
                            cursorColor: Colors.amber,
                            maxLines: maxLines,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'Please key in your To-Do list here',
                              fillColor: Colors.white,
                              filled: false,
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                            child: Text(
                            "Start Date",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _dateTimeStart == null ? 'Select a date' : DateFormat('dd MMM yyyy').format(_dateTimeStart),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                              IconButton(
                                icon: Icon(Icons.expand_more, color: Colors.grey),
                                onPressed: () { 
                                  _focusNode.unfocus();
                                  showDatePicker(
                                    context: context, 
                                    initialDate: DateTime.now(), 
                                    firstDate: DateTime(2000), 
                                    lastDate: DateTime(2030)
                                  ).then((date) => {
                                    setState((){
                                      _dateTimeStart = date;
                                    })
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                            child: Text(
                            "Estimate End Date",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _dateTimeEnd == null ? 'Select a date' : DateFormat('dd MMM yyyy').format(_dateTimeEnd),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                              ),
                              IconButton(
                                icon: Icon(Icons.expand_more, color: Colors.grey),
                                onPressed: () { 
                                  _focusNode.unfocus();
                                  showDatePicker(
                                    context: context, 
                                    initialDate: DateTime.now(), 
                                    firstDate: DateTime(2000), 
                                    lastDate: DateTime(2030)
                                  ).then((date) => {
                                    setState((){
                                      _dateTimeEnd = date;
                                    })
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Material(
              color: Colors.black,
              child: InkWell(
                onTap: () {
                  _focusNode.unfocus();
                  addTodoList();
                  ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.home);
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "Create Now",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ),
      ],
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