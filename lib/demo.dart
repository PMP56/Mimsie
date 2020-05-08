import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimsie/services/firestore.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 20, 29, 1),
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 80,
                        spreadRadius: 80,
                        offset: Offset(10, 10)
                    )
                  ],
                ),
                //alignment: Alignment.center,
                child: Image.asset('assets/logo.png', fit: BoxFit.contain, width: _width,),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/avatar1.png', fit: BoxFit.contain, width: 45,),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ': lordmani',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Infographic'),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'This is so funny',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Roberto', letterSpacing: 0.3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  FloatingActionButton(
                    child: Image.asset('assets/icons/haha.png', height: 50, fit: BoxFit.contain,),
                    elevation: 20,
                    backgroundColor: Colors.transparent,
                    onPressed: (){},
                  ),
                  Text('500', style: TextStyle(color: Colors.white),),
                  SizedBox(height: 20,),
                  IconButton(
                    icon: Icon(Icons.message, color: Colors.white,),
                    iconSize: 35,
                    onPressed: (){},
                  ),
                  Text('100', style: TextStyle(color: Colors.white),),
                  SizedBox(height: 20,),
                  IconButton(
                    icon: Icon(Icons.star_border, color: Colors.white,),
                    iconSize: 40,
                    onPressed: (){},
                  ),
                  Text('70', style: TextStyle(color: Colors.white),),
                  SizedBox(height: 20,),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.white,),
                    iconSize: 35,
                    onPressed: (){
                    },
                  ),
                  Text('Share', style: TextStyle(color: Colors.white, letterSpacing: 1),),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
