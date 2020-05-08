import 'package:flutter/material.dart';
import 'package:mimsie/auth/setup.dart';


class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topCenter,
//            end:  Alignment.bottomCenter,
//            colors: [Color.fromRGBO(0, 20, 30, 0.8), Color.fromRGBO(0, 20, 28, 0.9)]
//          )
//        ),
        color: Color.fromRGBO(0, 20, 30, 0.9),
        child: Column(
          children: <Widget>[
            ClipPath(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.lightBlue, Colors.greenAccent]
                  ),
                ),
                  alignment: Alignment.bottomRight,
                  child: Image.asset('assets/welcome.png', fit: BoxFit.contain, width: _width,)
              ),
              clipper: WelcomeClipper(),
            ),
            SizedBox(height: 20,),
            Text(
              'Mimsie',
              style: new TextStyle(
                fontFamily: 'Infographic',
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75
              ),
            ),
            SizedBox(height: 10,),
            Text(
              'Create and Share Memes',
              style: new TextStyle(
                  fontFamily: 'Infographic',
                  fontSize: 16,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w200,
                  letterSpacing: 1
              ),
            ),
            Container(
              height: 5 * _height / 16,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[300], Colors.blueGrey[100]]
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      //fromRGBO(0, 20, 28, 1)
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: Offset(5, 5)
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Set up an Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Infographic',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: _width / 2,
                        child: Text(
                          'Let me guide you through the process. It will take just few steps.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 15,),
                      RaisedButton(

                        padding: EdgeInsets.symmetric(vertical: _height / 70, horizontal: 45),
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                            'Get Started',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => UserSetup()));
                        },
                      ),
                    ],
                  ),
                  Image.asset('assets/man3.png', fit: BoxFit.contain, height: 9 * _height / 32,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey[300], Colors.blueGrey[100]]
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      //fromRGBO(0, 20, 28, 1)
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(5, 5)
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Times New Roman'
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)
                    ),
                    color: Colors.green[500],
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Times New Roman'
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class WelcomeClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 45);
    path.quadraticBezierTo(size.width / 4, size.height - 12, size.width / 2, size.height - 12);
    path.quadraticBezierTo(3 * size.width / 4, size.height - 12, size.width, size.height - 45);
    path.lineTo(size.width, 0.0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
