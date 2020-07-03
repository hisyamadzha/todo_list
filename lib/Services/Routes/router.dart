import 'package:auto_route/auto_route_annotations.dart';
import 'package:todolist/Controller/approot.dart';
import 'package:todolist/Controller/home.dart';
import 'package:todolist/Controller/addtodo.dart';

// ##### NEED TO RUN TO GENERATE ROUTES ######
// flutter packages pub run build_runner watch
// ###########################################

@MaterialAutoRouter()
class $Router {
  @initial
  AppRoot appRoot;
  Home home;
  AddToDo addToDo;
}
