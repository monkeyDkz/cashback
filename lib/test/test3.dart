import 'package:cash_back/modules/basic_screens/FavoritesScreen.dart';
import 'package:cash_back/modules/basic_screens/HistoriqueScreen.dart';
import 'package:cash_back/modules/basic_screens/HomeScreen.dart';
import 'package:cash_back/modules/basic_screens/ProfileScreen.dart';
import 'package:cash_back/modules/basic_screens/RemboursementScreen.dart';
import 'package:cash_back/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class test3 extends StatefulWidget {
  const test3({Key? key}) : super(key: key);

  @override
  State<test3> createState() => _test3State();
}

class _test3State extends State<test3> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  late bool _hideNavBar ;
  void initState() {
    super.initState();
    _controller = PersistentTabController();
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreene(),
      FavoritsScreen(),
      RemboursementScreen(),
      HistoriqueScreen(),
      ProfilScreen()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_favorites),
        title: ("Favorite"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed:(p0) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: RemboursementScreen(),


          );
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (contex) => const RemboursementScreen()));

        },
        icon: Icon(CupertinoIcons.rectangle_stack_badge_minus,color: Colors.white,),
        title: ("Remboursement"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(

        icon: Icon(CupertinoIcons.settings),
        title: ("Favorite"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Favorite"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(

      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      hideNavigationBar: _hideNavBar,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style16, // Choose the nav bar style with this property.
    );
  }
}
