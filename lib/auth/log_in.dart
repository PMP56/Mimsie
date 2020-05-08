import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimsie/services/auth.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String _email;
  String _password;

  bool loginFail = false;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _secondWave = 3 * MediaQuery.of(context).size.height / 4;

    //bool loginFail = false;
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
                color: Colors.cyan,
                child: Container(
                  height: 2 * _height / 5,
                  color: Colors.black87,
                ),
              ),
              //padding: EdgeInsets.only(bottom: 4),
              clipper: WaveClipper(),
            ),
            ClipPath(
              child: Container(
                color: Colors.cyan,
                child: Container(
                  margin: EdgeInsets.only(top: _secondWave),
                  height: _height,
                  color: Colors.black87,
                ),
              ),
              //padding: EdgeInsets.only(bottom: 4),
              clipper: WaveClipper3(_secondWave),
            ),
            Positioned(
              top: 3 * _height / 32,
              left: 7 * _width / 32 ,
              child: Image.asset('assets/logo_white.png', fit: BoxFit.cover, width: 3 * _width / 5,),
            ),
            Positioned(
              top: 9 * _height / 32,
              left: _width / 8 - 6,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white70,
                            //fromRGBO(0, 20, 28, 1)
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _email = value.trim();
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
                            errorText: loginFail? 'Email or password didn\'t match' : null,
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value.trim();
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
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                              ),
                            )
                          ),
                          color: Colors.blue,
                          onPressed: () async{
                            await AuthService().signIn(_email, _password).then((uid){
                              if (uid == null){
                                print('Fail');
                                setState(() {
                                  loginFail = true;
                                });
                              }else{
                                Navigator.of(context).pushReplacementNamed('/home');
                              }
                            });
                          },
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(child: Divider(color: Colors.grey[500], thickness: 1,)),
                            Text('  OR  '),
                            Expanded(child: Divider(color: Colors.grey[500], thickness: 1,))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          color: Colors.redAccent,
                          child: Container(
                            width: 250,
                            padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
                            alignment: Alignment.center,
                            child: Text(
                              'Login with Google',
                              style: TextStyle(color: Colors.white, fontSize: 16,),
                            ),
                          ),
                          onPressed: (){},

                        ),
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
                    height: 120,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
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
                          color: Colors.green[600],
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
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/landingpage');
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

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 325);
    path.quadraticBezierTo(size.width / 32, 345, size.width / 8, 345);
    path.lineTo(size.width - size.width / 8, 345);
    path.quadraticBezierTo(size.width - size.width / 32, 345, size.width, 325);
//    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper3 extends CustomClipper<Path> {
  double secondWave;
  WaveClipper3(double secondWave){
    this.secondWave = secondWave;
  }

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, secondWave + 20);
    path.quadraticBezierTo(size.width / 32, secondWave, size.width / 8, secondWave);
    path.lineTo(size.width - size.width / 8, secondWave);
    path.quadraticBezierTo(size.width - size.width / 32, secondWave, size.width, secondWave + 20);
//    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}