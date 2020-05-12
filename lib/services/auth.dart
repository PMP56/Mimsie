import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth{
  Future<String> signIn(String email, String password);

  Future<FirebaseUser> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class AuthService implements BaseAuth{
  String uid;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  getDirectUid() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return uid;
  }

  Future<String> getCurrentUid() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

//  Future<bool> signInWithEmail(userEmail, userPass, context) async{
//    try{
//      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: userEmail, password: userPass)).user;
//      print(user.uid);
//      if (user.uid.isNotEmpty){
//        Navigator.of(context).pushReplacementNamed('/home');
//        return null;
//      }
//      else{
//        print('Not found');
//        return false;
//      }
//    }catch(e){
//      print(e.toString());
//      return false;
//    }
  }
