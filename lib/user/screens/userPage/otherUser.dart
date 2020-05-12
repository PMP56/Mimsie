import 'package:flutter/material.dart';
import 'package:mimsie/user/screens/userPage/user.dart';

class OtherUser extends StatefulWidget {
  final uid;
  OtherUser({Key key, this.uid}) : super(key: key);
  @override
  _OtherUserState createState() => _OtherUserState();
}

class _OtherUserState extends State<OtherUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Color.fromRGBO(0, 20, 30, 1),
          centerTitle: true,

          title: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Image.asset(
                'assets/logo_white.png',
                fit: BoxFit.cover,
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
      body: User(uid: widget.uid,),
    );
  }
}
