import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mimsie/services/auth.dart';
import 'package:mimsie/models/posts.dart';

class UserImages extends StatefulWidget {
  @override
  _UserImagesState createState() => _UserImagesState();
}

class _UserImagesState extends State<UserImages> {

  bool showExit = true;

  @override
  Widget build(BuildContext context) {
    //String s = await AuthService().getCurrentUid();
    final posts = Provider.of<List<Post>>(context);
    return Container(
      height: 400,
      padding: EdgeInsets.only(bottom: 0),
      child: GridView.builder(
          itemCount: posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            //mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () {
                },
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                //color: Colors.white,
                child: Image.network(posts[index].postLink),
              ),
            );
          }
      ),
    );
  }
}
