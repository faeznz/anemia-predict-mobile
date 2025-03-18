import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:predict_anemia/constant/color_constant.dart';
import 'package:predict_anemia/view/about/about_screen.dart';
import 'package:predict_anemia/view/history/hostory_screen.dart';
import 'package:predict_anemia/view/home/home_screen.dart';

class MyButtomNavbar extends StatefulWidget {
  const MyButtomNavbar({super.key});

  @override
  State<MyButtomNavbar> createState() => _MyButtomNavbarState();
}

class _MyButtomNavbarState extends State<MyButtomNavbar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HistoryScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorConstant.whiteColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.house),
            label: '',
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const FaIcon(
                FontAwesomeIcons.house,
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.bars),
            label: '',
            activeIcon: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.circleInfo),
            label: '',
            activeIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const FaIcon(
                FontAwesomeIcons.circleInfo,
                color: Colors.white,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorConstant.primaryColor,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
