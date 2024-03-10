import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cash_back/logIn/FirstScreen.dart';
import 'package:cash_back/modules/Layout/HomeLayout1.dart';
import 'package:cash_back/modules/Layout/RemboursementSteps.dart';
import 'package:cash_back/modules/basic_screens/HomeScreen.dart';
import 'package:cash_back/modules/basic_screens/RemboursementScreen.dart';
import 'package:cash_back/modules/basic_screens/FavoritesScreen.dart';
import 'package:cash_back/modules/basic_screens/ProfileScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/network/local/cash_helper.dart';
import '../basic_screens/HistoriqueScreen.dart';

class HomeLayout extends StatefulWidget {


   HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0 ;

  final _pageController = PageController(initialPage:0);

  /// widget list
  final List<Widget> bottomBarPages = [
    HomeScreene(),
    FavoritsScreen(),
    HistoriqueScreen(),
    ProfilScreen(),
  ];
  final List<String> barLabels = [
    'Home',
    'page2',
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
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog to confirm app exit
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm exit'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ).then((value) {
          // If the user confirmed, close the app
          if (value == true) {
            SystemNavigator.pop();
          }
        });

        // Always return false to prevent the user from leaving the screen
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              bottomBarPages.length, (index) => bottomBarPages[index]),
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
        bottomNavigationBar: BottomAppBar(
          height: 55,

          color: Colors.white,



          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  tooltip: 'Open navigation menu',
                  icon:  Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined,
                  color: currentIndex == 0 ? mainColor : Colors.grey,
                    size: currentIndex == 0 ? 35 : 25,
                  ),
                  onPressed: () {


                      setState(() {
                        currentIndex = 0;
                        _pageController.jumpToPage(0);
                      });

                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  tooltip: 'Open navigation menu',
                  icon:  Icon(currentIndex == 1 ? Icons.favorite : Icons.favorite_border,
                    color: currentIndex == 1 ? mainColor : Colors.grey,
                    size: currentIndex == 1 ? 35 : 25,
                  ),
                  onPressed: () {
                      setState(() {
                        currentIndex = 1;
                        _pageController.jumpToPage(1);
                      });
                  },
                ),
              ),
               Expanded(child: SizedBox()),
              Expanded(
                child: IconButton(
                  tooltip: 'history',
                  icon:  Icon(Icons.history,
                        color: currentIndex == 2 ? mainColor : Colors.grey,
                    size: currentIndex == 2 ? 35 : 25,
                  ),
                  onPressed: () {
                    CashHelper.getData(key: 'account').then((value){
                      setState(() {
                        if(value?[2] != null){
                          currentIndex = 2;
                          _pageController.jumpToPage(2);
                        }
                        else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => const FirstScreen()));
                        }

                      });


                    });
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  tooltip: 'Favorite',
                  icon:  Icon(Icons.person,
                    color: currentIndex == 3 ? mainColor : Colors.grey,
                    size: currentIndex == 3 ? 35 : 25,),
                  onPressed: () {
                      setState(() {
                        CashHelper.getData(key: 'account').then((value){
                          setState(() {
                            if(value?[2] != null){
                              currentIndex = 3;
                              _pageController.jumpToPage(3);
                            }
                            else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => const FirstScreen()));
                            }

                          });


                        });

                      });

                  },
                ),
              ),
            ],
          ),
        ),


      ),
    );
  }
}


