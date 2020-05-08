import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mimsie/user/screens/uploader.dart';


class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _imageFile;
  String _postText;
  int _pageIndex = 1;

  Future<void> pickImage() async{
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = selected;
    });
    return selected.path;
  }

  Widget picUpload(context){
    double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/avatar1.png', fit: BoxFit.contain, width: 50,),
              SizedBox(width: 15,),
              Container(
                width: 3 * _width / 4,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Caption...',
                  ),
                  onChanged: (value){
                    setState(() {
                      _postText = value;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 5,),
          Divider(thickness: 2,),
          SizedBox(height: 5,),
          if (_imageFile == null)
            Container(
              height: 40,
              child: RaisedButton(
                elevation: 5,
                color: Colors.lightBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_photo_alternate, size: 30, color: Colors.white,),
                    SizedBox(width: 10,),
                    Text('Upload a photo', style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
                onPressed: (){
                  pickImage();
                },
              ),
            ),
          //SizedBox(height: 20,),
          if (_imageFile != null) ...[
            Image.file(_imageFile, height: 400,),
            SizedBox(height: 10,),
            Uploader(file: _imageFile, caption: _postText)
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        //color: Color.fromRGBO(0, 20, 30, 1),
        height: 196 * _height / 240,
        color: Colors.grey[200],
        child: Stack(
          children: <Widget>[

            picUpload(context),
            SizedBox(height: 30,),
            Positioned(
              bottom: 0,
              child: ClipPath(
                clipper: (_pageIndex == 1)?FirstClipper() : SecondClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 20, 30, 1),
                    //border: Border.all(width: 3, color: Colors.white)
                  ),
                  //alignment: Alignment.bottomCenter,
                  width: _width,
                  height: 45,
                ),
              ),
            ),
            Positioned(
              bottom: (_pageIndex == 1)? 15 : 0,
              left: 70,
              child: IconButton(
                icon: Icon(Icons.image, color: (_pageIndex == 1)? Color.fromRGBO(0, 20, 30, 1) : Colors.white,),
                iconSize: (_pageIndex == 1)? 40 : 30,
                onPressed: (){
                  setState(() {
                    _pageIndex = 1;
                  });
                },
              ),
            ),
            Positioned(
              bottom: (_pageIndex == 2)? 15 : 0,
              right: 80,
              child: IconButton(
                icon: Icon(Icons.camera, color: (_pageIndex == 2)? Color.fromRGBO(0, 20, 30, 1) : Colors.white,),
                iconSize: (_pageIndex == 2)? 40 : 30,
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
    );
  }
}

class FirstClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    double startPoint = 29.0;

    var path = new Path();
    path.lineTo(startPoint, 0.0);
    path.quadraticBezierTo(startPoint + 3, 0, startPoint + 6, 4);
    path.lineTo(startPoint + 20, size.height - 14);
    path.quadraticBezierTo(startPoint + 23, size.height - 10, startPoint + 26, size.height - 10);
    path.lineTo(startPoint + 130 - 15, size.height - 10);
    path.quadraticBezierTo(startPoint + 133 - 15, size.height - 10, startPoint + 136 - 15, size.height - 14);
    path.lineTo(startPoint + 150 - 15, 4);
    path.quadraticBezierTo(startPoint + 153 - 15, 0.0, startPoint + 156 - 15, 0.0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SecondClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    double startPoint = size.width - 184;

    var path = new Path();
    path.lineTo(startPoint, 0.0);
    path.quadraticBezierTo(startPoint + 3, 0, startPoint + 6, 4);
    path.lineTo(startPoint + 20, size.height - 14);
    path.quadraticBezierTo(startPoint + 23, size.height - 10, startPoint + 26, size.height - 10);
    path.lineTo(startPoint + 130 - 15, size.height - 10);
    path.quadraticBezierTo(startPoint + 133 - 15, size.height - 10, startPoint + 136 - 15, size.height - 14);
    path.lineTo(startPoint + 150 - 15, 4);
    path.quadraticBezierTo(startPoint + 153 - 15, 0.0, startPoint + 156 - 15, 0.0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}