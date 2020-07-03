import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todolist/Model/todomodel.dart';
import 'package:todolist/Services/Routes/router.gr.dart';
import 'package:todolist/Services/Storage/storage.dart';

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key key }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // Insert initial data
      Storage.shared.add(new ToDoModel(null, "Automated Testing Script", new DateTime(2019, 10, 21), new DateTime(2019, 10, 23), false));
      ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.home);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}