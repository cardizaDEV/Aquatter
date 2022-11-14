import 'package:aquatter/screens/pages/pages.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  int get tabIndex => _index;
  set tabIndex(int v) {
    _index = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(defaultPadding),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryColor, 
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
           ),
          backgroundColor: primaryColor,
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CircleNavBar(
      activeIcons: const [
        Icon(Icons.people, color: Colors.white),
        Icon(Icons.search, color: Colors.white),
        Icon(Icons.add, color: Colors.white),
        Icon(Icons.settings, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
      inactiveIcons: const [
        Icon(Icons.people, color: Colors.white),
        Icon(Icons.search, color: Colors.white),
        Icon(Icons.add, color: Colors.white),
        Icon(Icons.settings, color: Colors.white),
        Icon(Icons.person, color: Colors.white),
      ],
      color: primaryColor,
      height: 60,
      circleWidth: defaultPadding*6,
      padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
      cornerRadius: const BorderRadius.only(
        bottomRight: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      ),
      elevation: 10,
      activeIndex: _index,
      onTab: (v) {
        _index = v;
        pageController.jumpToPage(_index);
      },
    ),
    body: PageView(
      controller: pageController,
      onPageChanged: (v) {
          tabIndex = v;
        },
        children: const [
           SocialPage(),
           SearchPage(),
           PostPage(),
           ManagerPage(),
           ProfilePage()
        ],
    ),
    );
  }
}
