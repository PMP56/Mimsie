import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimsie/models/posts.dart';
import 'package:mimsie/models/users.dart';

final db = Firestore.instance;

class UserManagement {
  storeNewUser(user, context, [details]) {
    db.collection('/users').add({
      'email': user.email,
      'nickname': details[0],
      'avatarIndex': details[1],
      'uid': user.uid,
      'followersCount': 0,
      'followingCount': 0,
      'reactCount': 0,
      'description': 'Click here to add description',
    }).then((value) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');
    }).catchError((e) {
      print(e);
    });
  }
}

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference postCollection = Firestore.instance.collection('posts');

  Future getUser(String uid) async {
    QuerySnapshot qn = await userCollection.where('uid', isEqualTo: uid).getDocuments();
    return qn.documents;
  }
  
  Future addPost(String link, String postText) async{
    return await postCollection.add({
      'uid': uid,
      'postLink': link,
      'postText': postText,
      'likeCount': 0,
      'comment': {},
      'favCount': 0,
      'viewCount': 1,
      'dateTime': Timestamp.now(),
    });
  }
  //post list from snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Post(
        uid: doc.data['uid'] ?? '',
        userName: doc.data['userName'] ?? '',
        postLink: doc.data['postLink'] ?? '',
        postText: doc.data['postText'] ?? '',
        likeCount: doc.data['likeCount'] ?? 0,
        favCount: doc.data['favCount'] ?? 0,
        viewCount: doc.data['viewCount'] ?? 0,
        //dateTime: Timestamp.fromDate(doc.data['dateTime']),
      );
    }).toList();
  }

  //get post streams
  Stream<List<Post>> get posts{
    return postCollection.orderBy('dateTime', descending: true).snapshots().map(_postListFromSnapshot);
  }

  Stream<List<Post>> get userPosts{
    return postCollection.where('uid', isEqualTo: uid).snapshots().map(_postListFromSnapshot);
  }
  
}
