import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zsnap/screens/pages/camera_page.dart';
import 'dart:io' show Platform;

import '../utils/color_resources.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 2; // Default to Snap page (index 2)
  final PageController _pageController = PageController(initialPage: 2);

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          Container(color: Colors.white), // Location tab
          Container(color: Colors.white), // Chat tab
          const CameraPage(),
          Container(color: Colors.white), // Stories tab
          Container(color: Colors.white), // Profile tab
        ],
      ),
      bottomNavigationBar: Platform.isIOS
          ? CupertinoTabBar(
              backgroundColor: IOSColorResources.BLACK,
              activeColor: IOSColorResources.COLOR_PRIMARY,
              inactiveColor: IOSColorResources.GRAY_MEDIUM,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              border: null,
              height: 60,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.location_fill, size: 28),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_fill, size: 28),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.camera_fill, size: 32),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_circle_fill, size: 28),
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_fill, size: 28),
                ),
              ],
            )
          : NavigationBar(
              backgroundColor: AndroidColorResources.BLACK,
              height: 60,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.location_on_outlined,
                      color: AndroidColorResources.GRAY_MEDIUM, size: 28),
                  selectedIcon: Icon(Icons.location_on,
                      color: AndroidColorResources.COLOR_PRIMARY, size: 28),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_bubble_outline,
                      color: AndroidColorResources.GRAY_MEDIUM, size: 28),
                  selectedIcon: Icon(Icons.chat_bubble,
                      color: AndroidColorResources.COLOR_PRIMARY, size: 28),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(Icons.camera_alt_outlined,
                      color: AndroidColorResources.GRAY_MEDIUM, size: 32),
                  selectedIcon: Icon(Icons.camera_alt,
                      color: AndroidColorResources.COLOR_PRIMARY, size: 32),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(Icons.play_circle_outline,
                      color: AndroidColorResources.GRAY_MEDIUM, size: 28),
                  selectedIcon: Icon(Icons.play_circle_filled,
                      color: AndroidColorResources.COLOR_PRIMARY, size: 28),
                  label: '',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline,
                      color: AndroidColorResources.GRAY_MEDIUM, size: 28),
                  selectedIcon: Icon(Icons.person,
                      color: AndroidColorResources.COLOR_PRIMARY, size: 28),
                  label: '',
                ),
              ],
            ),
    );
  }
}
