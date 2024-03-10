import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cash_back/modules/basic_screens/HomeScreen.dart';
import 'package:cash_back/modules/basic_screens/RemboursementScreen.dart';
import 'package:cash_back/modules/basic_screens/FavoritesScreen.dart';
import 'package:cash_back/modules/basic_screens/ProfileScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basic_screens/HistoriqueScreen.dart';

class HomeLayout1 extends StatefulWidget {
  const HomeLayout1({Key? key}) : super(key: key);

  @override
  State<HomeLayout1> createState() => _HomeLayout1State();
}

class _HomeLayout1State extends State<HomeLayout1> {
  final _pageController = PageController(initialPage: 0);


  int currentIndex =0;

  /// widget list
  final List<Widget> screens = [
    HomeScreene(),
    FavoritsScreen(),
    RemboursementScreen(),
    HistoriqueScreen(),
    ProfilScreen(),
  ];
  final List<String> titles = [
    'Home',
    'Favorite',
    'page3',
    'page4',
    'page5',

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            screens.length, (index) => screens[index]),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white)
        ),
        backgroundColor: mainColor,

        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) => const RemboursementScreen()));
        },
        child: Icon(Icons.add)
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: currentIndex,
        onTap: (index) async{
          setState(() {

            if(index!=2){
              currentIndex = index;
              // _pageController.animateToPage(
              //   index,
              //   duration: const Duration(milliseconds: 300),
              //   curve: Curves.easeIn,
              // );
              _pageController.jumpToPage(index);
            }


          });

        },
        items: [
          BottomNavigationBarItem(icon:
          Icon(Icons.home,
          ),
            label: titles[0],

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,

            ),
            label: titles[1],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined,

            ),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined,

            ),
            label: titles[3],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,

            ),
            label: titles[4],
          ),
        ],
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(size: 35),

        selectedItemColor: mainColor,
      ),
    );
  }
}
