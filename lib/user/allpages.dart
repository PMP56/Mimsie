import 'package:flutter/material.dart';
import 'screens/upload.dart';
import 'screens/home.dart';
import 'screens/Highlights.dart';
import 'screens/search.dart';
import 'screens/userPage/user.dart';
import 'package:mimsie/services/auth.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int currentPage = 0;
  String uid;


  void _getCurrentUid() async {
    String s = await AuthService().getCurrentUid();
    setState(() {
      uid = s;
    });
  }

  List<BottomNavigationBarItem> buildBottomNav(){
    return [
      BottomNavigationBarItem(
        icon: new Icon(Icons.home, size: 25,),
        activeIcon: Icon(Icons.home, size: 30,),
        title: new Text('Home'),

      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.flare, size: 25,),
        activeIcon: Icon(Icons.flare, size: 30,),
        title: new Text('Highlights'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.add_a_photo, size: 25,),
        activeIcon: Icon(Icons.add_a_photo, size: 30,),
        title: new Text('Add'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.search, size: 25,),
        activeIcon: Icon(Icons.search, size: 30,),
        title: new Text('Search'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.person_outline, size: 25,),
        activeIcon: Icon(Icons.person, size: 30,),
        title: new Text('User'),
      ),
    ];
  }



  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView(){
    return PageView(
      controller: pageController,
      physics: BouncingScrollPhysics(),
      onPageChanged: (index){
        pageChanged(index);
        if(index == 4){
          _getCurrentUid();
        }
      },
      children: <Widget>[
        Home(),
        Highlights(),
        Upload(),
        Search(),
        User(uid: uid,),
      ],
    );
  }

  @override
  void initState(){
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void bottomTapped(int index){
    setState(() {
      currentPage = index;
      pageController.animateToPage(index, duration: Duration(microseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Color.fromRGBO(0, 20, 30, 1),
            centerTitle: true,

            title: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Image.asset(
                  'assets/logo_white.png',
                  fit: BoxFit.cover,
                  height: 60.0,
                ),
              ],
            ),
          ),
        ),
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(0, 20, 30, 1),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: buildBottomNav(),
          currentIndex: currentPage,
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.white,
          onTap: (index){
            bottomTapped(index);
            if(index == 4){
              _getCurrentUid();
            }
          },
        )
    );
  }
}