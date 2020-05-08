import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimsie/services/firestore.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email;
  String _password;
  String _fullName;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.white70,
        height: _height,
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            ClipPath(
              child: Container(
                color: Colors.redAccent,
                child: Container(
                  height: 325,
                  color: Color.fromRGBO(0, 0, 0, 0.9),
                ),
              ),
              //padding: EdgeInsets.only(bottom: 4),
              clipper: WaveClipper(),
            ),
            ClipPath(
              child: Container(
                color: Colors.redAccent,
                child: Container(
                  margin: EdgeInsets.only(top: 600),
                  height: _height,
                  color: Color.fromRGBO(0, 0, 0, 0.9),
                ),
              ),
              //padding: EdgeInsets.only(bottom: 4),
              clipper: WaveClipper3(),
            ),
            Positioned(
              top: 3 * _height / 32,
              left: 7 * _width / 32 ,
              child: Image.asset('assets/logo_white.png', fit: BoxFit.cover, width: 3 * _width / 5,),
            ),
            Positioned(
              top: _height / 4 + 20 ,
              left: _width / 8,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white70,
                            blurRadius: 0,
                            spreadRadius: 12,
                            offset: Offset(0, 0)
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      //border: Border.all(width: 2, color: Colors.grey[800]),
                      color: Colors.white,

                    ),
                    width:  3 * _width / 4,
                    height: 340,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Full Name',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _fullName = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          child: Container(
                              width: 250,
                              padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                              alignment: Alignment.center,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              )
                          ),
                          color: Colors.green[600],
                          onPressed: () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: _email, password: _password)
                                .then((signedUser) {

                              UserManagement().storeNewUser(signedUser.user, context, _fullName);
                            }).catchError((e) {
                              print(e);
                            });
                          },
                        ),
                        SizedBox(height: 10,),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white70,
                            blurRadius: 0,
                            spreadRadius: 12,
                            offset: Offset(0, 0)
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      //border: Border.all(width: 2, color: Colors.grey[800]),
                      color: Colors.white,

                    ),
                    width:  3 * _width / 4,
                    height: 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          color: Colors.blue[600],
                          child: Container(
                            width: 250,
                            padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                            alignment: Alignment.center,
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/login');
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
    );
  }
}


class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(size.width / 32, size.height, size.width / 8, size.height);
//    path.lineTo(size.width / 8, size.height - 80);
//    path.quadraticBezierTo(size.width / 16 + 25, size.height / 2 + 60, size.width / 8 + 20, size.height - 100);
//    path.lineTo(size.width - (size.width / 8 + 20), size.height - 100);
//    path.quadraticBezierTo(size.width - (size.width / 16 + 25), size.height / 2 + 60, size.width - (size.width / 8), size.height - 80);
//    path.lineTo(size.width - (size.width / 8), size.height);
    path.lineTo(size.width - size.width / 8, size.height);
    path.quadraticBezierTo(size.width - size.width / 32, size.height, size.width, size.height - 20);
//    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 620);
    path.quadraticBezierTo(size.width / 32, 600, size.width / 8, 600);
    path.lineTo(size.width - size.width / 8, 600);
    path.quadraticBezierTo(size.width - size.width / 32, 600, size.width, 620);
//    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
