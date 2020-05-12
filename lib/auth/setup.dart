import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimsie/auth/welcome.dart';
import 'package:mimsie/services/auth.dart';
import 'package:mimsie/services/firestore.dart';

class UserSetup extends StatefulWidget {
  @override
  _UserSetupState createState() => _UserSetupState();
}

class _UserSetupState extends State<UserSetup> {
  String _nickname = '';
  String _email = '';
  String _password = '';
  int _avatarIndex = 1;
  bool loginFail = false;

  bool checkCurrent(int index){
    if (_avatarIndex == index){
      return true;
    }else{
      return false;
    }
  }

  Widget avatarCollection(){
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 1;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(1)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar1.png', fit: BoxFit.contain,),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 2;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(2)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar2.png', fit: BoxFit.contain,),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 3;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(3)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar3.png', fit: BoxFit.contain,),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 4;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(4)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar4.png', fit: BoxFit.contain,),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 5;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(5)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar5.png', fit: BoxFit.contain,),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                _avatarIndex = 6;
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: checkCurrent(6)? Border.all(width: 2, color: Colors.white) : null,
              ),
              width: 100.0,
              child: Image.asset('assets/avatar6.png', fit: BoxFit.contain,),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(0, 20, 30, 1),
        child: ListView(
          scrollDirection: Axis.vertical,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.cyanAccent, Colors.amberAccent]
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/setup.png', fit: BoxFit.contain, width: _width,)
              ),
              clipper: WelcomeClipper(),
            ),
            SizedBox(height: 20,),
            Container(
              width: _width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Personal Information',
                    style: TextStyle(
                      fontFamily: 'Infographic',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ' Nickname: ',
                          style: TextStyle(
                            letterSpacing: 0.5,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.face),
                            hintText: 'Nickname',
                            errorText: loginFail ? 'Nickname is required' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          onChanged: (value) {
                            setState(() {
                              _nickname = value.toLowerCase();
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        Text(
                          ' Avatar: ',
                          style: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 10,),
                        avatarCollection(),
                        SizedBox(height: 20,),
                        Text(
                          ' Email: ',
                          style: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                          ),
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        Text(
                          ' Password: ',
                          style: TextStyle(
                              letterSpacing: 0.5,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              errorText: loginFail? 'Email or Password is incorrect' : null,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        ),
                        SizedBox(height: 25,),
                        Container(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Colors.redAccent,
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w800),
                            ),
                            onPressed: ()async{
                              if (_nickname == '' || _email == '' || _password ==''){
                                setState(() {
                                  loginFail = true;
                                });
                              }else {
                                await AuthService()
                                    .signUp(_email, _password)
                                    .then((user) {
                                  UserManagement().storeNewUser(
                                      user, context, [_nickname, _avatarIndex]);
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),

                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
