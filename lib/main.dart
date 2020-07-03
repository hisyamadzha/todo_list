import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todolist/Services/Routes/router.gr.dart';

void main() {
  runApp(AppRootMain());
}

class AppRootMain extends StatefulWidget {
  @override
  _AppRootMainState createState() => new _AppRootMainState();
}

class _AppRootMainState extends State<AppRootMain> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-DO List',
      initialRoute: Routes.appRoot,
      onGenerateRoute: Router().onGenerateRoute,
      builder: ExtendedNavigator<Router>(router: Router()),
    );
  }
}