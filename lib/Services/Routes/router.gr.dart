// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todolist/Controller/approot.dart';
import 'package:todolist/Controller/home.dart';
import 'package:todolist/Controller/addtodo.dart';

abstract class Routes {
  static const appRoot = '/';
  static const home = '/home';
  static const addToDo = '/add-to-do';
  static const all = {
    appRoot,
    home,
    addToDo,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.appRoot:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AppRoot(),
          settings: settings,
        );
      case Routes.home:
        if (hasInvalidArgs<HomeArguments>(args)) {
          return misTypedArgsRoute<HomeArguments>(args);
        }
        final typedArgs = args as HomeArguments ?? HomeArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Home(key: typedArgs.key),
          settings: settings,
        );
      case Routes.addToDo:
        if (hasInvalidArgs<AddToDoArguments>(args)) {
          return misTypedArgsRoute<AddToDoArguments>(args);
        }
        final typedArgs = args as AddToDoArguments ?? AddToDoArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddToDo(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//Home arguments holder class
class HomeArguments {
  final Key key;
  HomeArguments({this.key});
}

//AddToDo arguments holder class
class AddToDoArguments {
  final Key key;
  AddToDoArguments({this.key});
}
