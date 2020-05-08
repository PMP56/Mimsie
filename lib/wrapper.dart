import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimsie/auth/log_in.dart';
import 'package:mimsie/auth/setup.dart';
import 'package:mimsie/auth/welcome.dart';
import 'package:mimsie/demo.dart';
import 'package:mimsie/user/allpages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
         if (snapshot.hasData){
          FirebaseUser user = snapshot.data;
          return MyHome();
        }
        else{
          return Welcome();
        }
      }
    );
  }
}
