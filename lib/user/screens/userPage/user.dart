import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mimsie/user/screens/userPage/userContent.dart';
import 'package:mimsie/services/firestore.dart';

class User extends StatefulWidget {
  final uid;
  User({Key key, this.uid}) : super(key: key);
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0, 20, 30, 1,),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          color: Color.fromRGBO(0, 20, 30, 1),
          child: FutureBuilder(
            future: DatabaseService().getUser(widget.uid),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: SpinKitThreeBounce(color: Colors.pink, size: 30,))
                );
              }else{
                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.lightBlueAccent)
                                ),
                                child: Image.asset('assets/avatar${snapshot.data[0].data['avatarIndex'].toString()}.png', fit: BoxFit.contain, width: 70,)
                            ),
                            SizedBox(height: 10,),
                            Text(
                              snapshot.data[0].data['nickname'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 2,),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data[0].data['followersCount'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data[0].data['followingCount'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'Followings',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20,),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data[0].data['reactCount'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'HAHAs',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25,),
                    Text(
                      snapshot.data[0].data['description'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 25,),
                    UserContent(uid: widget.uid,),
                    OutlineButton(
                      child: Text('Log Out', style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.of(context).pushReplacementNamed('/login');
                        }).catchError((e) {
                          print(e);
                        });
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
