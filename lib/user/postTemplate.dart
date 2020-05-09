import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimsie/services/firestore.dart';
import 'package:provider/provider.dart';
import 'package:mimsie/models/posts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PostTemplate extends StatefulWidget {
  @override
  _PostTemplateState createState() => _PostTemplateState();
}

class _PostTemplateState extends State<PostTemplate> {

  bool _postLike;
  bool _postFav;

  PreloadPageController controller = PreloadPageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget postModel(post, context){
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                child: FutureBuilder(
                  future: http.get('${post.postLink}'),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      return Image.network('${post.postLink}', fit: BoxFit.contain, width: _width,);
                    }
                    return Center(
                        child: SpinKitThreeBounce(color: Colors.pink, size: 30,)
                      //SpinKitWave(color: Colors.white, type: SpinKitWaveType.center, size: 40,),
                    );
                  },
                  //child: Image.network('${posts[index].postLink}', fit: BoxFit.contain, width: _width,)
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: _width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color.fromRGBO(0, 20, 30, 1), Color.fromRGBO(0, 20, 30, 0.9), Color.fromRGBO(0, 20, 30, 0.8), Color.fromRGBO(0, 20, 30, 0.6), Color.fromRGBO(0, 20, 30, 0.4),Color.fromRGBO(0, 20, 30, 0.1), Colors.transparent]
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder(
                        future: DatabaseService().getPostUser(post.uid),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Image.asset('assets/logo.png', fit: BoxFit.contain, width: 45, height: 45,);
                          }else{
                            String index = snapshot.data[0].data['avatarIndex'].toString();
                            return Image.asset('assets/avatar$index.png', fit: BoxFit.contain, width: 45,);
                          }
                        },
                        //child: Image.asset('assets/avatar1.png', fit: BoxFit.contain, width: 45,)
                      ),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white)
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FutureBuilder(
                          future: DatabaseService().getPostUser(post.uid),
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting){
                              return Text('...');
                            }else{
                              return Text(
                                ': ' + snapshot.data[0].data['nickname'],
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Infographic'),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        Text(
                          post.postText,
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Roberto', letterSpacing: 0.3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: _height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Color.fromRGBO(0, 20, 30, 0.5), Colors.transparent]
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    IconButton(
                      icon: Icon(Icons.people, color: Colors.white,),
                      iconSize: 30,
                      onPressed: (){},
                    ),
                    Text(post.viewCount.toString(), style: TextStyle(color: Colors.white),),
                    SizedBox(height: 15,),
                    IconButton(
                      icon: Icon(Icons.message, color: Colors.white,),
                      iconSize: 30,
                      onPressed: (){},
                    ),
                    Text('100', style: TextStyle(color: Colors.white),),
                    SizedBox(height: 15,),
                    FloatingActionButton(
                      child: Image.asset('assets/icons/haha.png', height: 40, fit: BoxFit.contain,),
                      elevation: 20,
                      backgroundColor: Colors.transparent,
                      onPressed: (){},
                    ),
                    Text(post.likeCount.toString(), style: TextStyle(color: Colors.white),),
                    SizedBox(height: 15,),
                    IconButton(
                      icon: Icon(Icons.star_border, color: Colors.white,),
                      iconSize: 35,
                      onPressed: (){},
                    ),
                    Text(post.favCount.toString(), style: TextStyle(color: Colors.white),),
                    SizedBox(height: 15,),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.white,),
                      iconSize: 30,
                      onPressed: (){},
                    ),
                    Text('Share', style: TextStyle(color: Colors.white, letterSpacing: 1),),
                  ],
                ),
              ),
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final posts = Provider.of<List<Post>>(context);

    //print(posts[0].uid);
    return PreloadPageView.builder(
      controller: PreloadPageController(),
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      preloadPagesCount: 2,
      itemBuilder: (context, index){
        return postModel(posts[index], context);
      },
    );
  }
}
