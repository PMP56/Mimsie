import 'package:flutter/material.dart';
import 'package:mimsie/auth/log_in.dart';
import 'package:mimsie/auth/sign_in.dart';
import 'package:mimsie/user/allpages.dart';
import 'package:mimsie/user/screens/userPage/user.dart';
import 'package:mimsie/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mimsie',
      home: Wrapper(),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => MyApp(),
        '/login': (BuildContext context) => LogIn(),
        '/signup': (BuildContext context) => SignIn(),
        '/home': (BuildContext context) => MyHome(),
      },
    );
  }
}
