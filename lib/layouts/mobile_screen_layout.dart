import 'package:concept/widget/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // activeIcon: ShaderMask(
            //   shaderCallback: (Rect bounds) {
            //     return RadialGradient(
            //       center: Alignment.topLeft,
            //       radius: 1.0,
            //       colors:  <Color> [
            //         Colors.red,
            //         Colors.black,
            //       ],
            //       //tileMode: TileMode.mirror,
            //     ).createShader(bounds);
            //   },
            //   child: Icon(
            //     Icons.home_filled,
            //   ),
            // ),
            // icon: Icon(
            //   Icons.home_filled,
            //   color: Colors.grey,
            // ),

            icon: Icon(
              Icons.home_filled,
              color: (_page == 0) ? Colors.black : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? Colors.black : Colors.grey,
              ),
              label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: GradientIcon(
              Icons.amp_stories_outlined,
              40.0,
              LinearGradient(
                colors: <Color>[
                  Color(0xFF28B6ED),
                  Color(0xFFFA0AFF),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.addchart_outlined,
              color: (_page == 3) ? Colors.black : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: (_page == 4) ? Colors.black : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.black,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
