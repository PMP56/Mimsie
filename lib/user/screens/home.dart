import 'package:flutter/material.dart';
import 'package:mimsie/services/firestore.dart';
import 'package:mimsie/user/postTemplate.dart';
import 'package:provider/provider.dart';
import '../../models/posts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Post>>.value(
        initialData: List(),
        value: DatabaseService().posts,
        child: Container(
            color: Color.fromRGBO(0, 20, 30, 1),
            child: PostTemplate()
        )
    );
  }
}