import 'dart:io';
import 'package:mimsie/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mimsie/services/firestore.dart';
import 'package:mimsie/user/screens/upload.dart';

class Uploader extends StatefulWidget {
  final File file;
  final String caption;
  Uploader({Key key, this.file, this.caption}) : super(key: key);
  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://mimsie-lm2056.appspot.com');
  StorageUploadTask _uploadTask;
  String downloadUrl;

  void _addToDatabase(String uid) async{
    await DatabaseService(uid: uid).addPost(downloadUrl, widget.caption);
  }

  void _startUpload() async{
    String s = await AuthService().getCurrentUid();
    String filepath = 'memes/${s}+${DateTime.now()}.png';

    final StorageReference ref = _storage.ref().child(filepath);
    setState(() {
      _uploadTask = ref.putFile(widget.file);
    });

    var downUrl = await (await _uploadTask.onComplete).ref.getDownloadURL();
    setState(() {
      downloadUrl = downUrl.toString();
    });
    if (_uploadTask.isComplete){
      _addToDatabase(s);
      Navigator.of(context).pushReplacementNamed('/home');
    }

  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null){
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot){
          var event = snapshot?.data?.snapshot;

          double progressPercent = event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete)
                Text('Complete'),


              LinearProgressIndicator(value: progressPercent,),
              Text('${(progressPercent * 100).toStringAsFixed(2)} %'),
            ],
          );

        }
      );

    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton.icon(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              color: Colors.lightBlue,
              onPressed: _startUpload,
              icon: Icon(Icons.cloud_upload, color: Colors.white,),
              label: Text('Post', style: TextStyle(color: Colors.white, fontSize: 16),)
          ),
          FlatButton.icon(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              color: Colors.redAccent,
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/home');
              },
              icon: Icon(Icons.remove_circle, color: Colors.white,),
              label: Text('Cancle', style: TextStyle(color: Colors.white, fontSize: 16),)
          ),
        ],
      );
        
    }
  }
}
