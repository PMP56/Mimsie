import 'dart:io';
import 'package:flutter/cupertino.dart';
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
      return Container(
        width: 375,
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          //color: Colors.black38,
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                    onPressed: _startUpload,
                    icon: Icon(Icons.cloud_upload, color: Colors.lightBlue[300], size: 35,),
                ),
                Text('Upload', style: TextStyle(color: Colors.white),)
              ],
            ),
            //VerticalDivider(thickness: 1, color: Colors.white,),
            Column(
              children: <Widget>[
                IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    icon: Icon(Icons.remove_circle, color: Colors.redAccent, size: 35,),
                ),
                Text('Cancel', style: TextStyle(color: Colors.white),)
              ],
            ),
          ],
        ),
      );
        
    }
  }
}
