import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimsie/user/postTemplate.dart';
import 'package:mimsie/user/screens/userPage/userImages.dart';
import 'package:provider/provider.dart';
import 'package:mimsie/services/firestore.dart';
import 'package:mimsie/services/auth.dart';
import 'package:mimsie/models/posts.dart';

class UserContent extends StatefulWidget {
  final uid;
  UserContent({Key key, this.uid}) : super(key: key);
  @override
  _UserContentState createState() => _UserContentState();
}

class _UserContentState extends State<UserContent> {
  int _pageIndex = 1;

  Widget imageCollection(){
    return StreamProvider<List<Post>>.value(
        initialData: List(),
        value: DatabaseService(uid: widget.uid).userPosts,
        child: Container(
            color: Color.fromRGBO(0, 20, 30, 1),
            child: UserImages()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: Colors.grey[800]),
                bottom: BorderSide(width: 2, color: Colors.grey[800]),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: (_pageIndex == 1) ? Colors.greenAccent: Color.fromRGBO(0, 20, 30, 1)),
                      )
                  ),
                  child: IconButton(
                    icon: Icon(Icons.compare, color: (_pageIndex == 1) ? Colors.greenAccent : Colors.grey[600], size: 30,),
                    onPressed: (){
                      setState(() {
                        _pageIndex = 1;
                      });
                    },
                  ),
                ),Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: (_pageIndex == 2) ? Colors.red[300]: Color.fromRGBO(0, 20, 30, 1)),
                      )
                  ),
                  child: IconButton(
                    icon: Icon(Icons.ac_unit, color: (_pageIndex == 2) ? Colors.red[300] : Colors.grey[600], size: 30,),
                    onPressed: (){
                      setState(() {
                        _pageIndex = 2;
                      });
                    },
                  ),
                ),


              ],
            ),
          ),
          SizedBox(height: 10,),
          if(_pageIndex == 2)
            Container()
          else
            imageCollection()
        ],
      ),
    );
  }
}
