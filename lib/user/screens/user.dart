import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[400],
      child: OutlineButton(
        child: Text('Log Out'),
        onPressed: () {
          FirebaseAuth.instance.signOut().then((value) {
            Navigator.of(context).pushReplacementNamed('/login');
          }).catchError((e) {
            print(e);
          });
        },
      ),
    );
  }
}
