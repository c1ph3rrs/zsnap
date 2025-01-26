import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int _selectedIndex = 2; // Default to Snap page (index 2)
  final PageController _pageController = PageController(initialPage: 2);
  bool _showLabels = false; // Controls whether labels are shown

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

  void _onLongPress() {
    setState(() {
      _showLabels = true; // Show labels on long press
    });
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
          Container(color: Colors.white), // Snap tab
          Container(color: Colors.white), // Stories tab
          Container(color: Colors.white), // Profile tab
        ],
      ),
      bottomNavigationBar: Platform.isIOS
          ? GestureDetector(
              onLongPress: _onLongPress, // Show labels on long press
              child: CupertinoTabBar(
                backgroundColor: Colors.black,
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.location),
                    label: _showLabels
                        ? 'Location'
                        : '', // Show label conditionally
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    label: _showLabels ? 'Chat' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.camera),
                    label: _showLabels ? 'Snap' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.play_circle),
                    label: _showLabels ? 'Stories' : '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person),
                    label: _showLabels ? 'Profile' : '',
                  ),
                ],
              ),
            )
          : NavigationBar(
              backgroundColor: Colors.black,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelBehavior: _showLabels
                  ? NavigationDestinationLabelBehavior.alwaysShow
                  : NavigationDestinationLabelBehavior
                      .onlyShowSelected, // Hide labels initially
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.location_on, color: Colors.grey),
                  selectedIcon: Icon(Icons.location_on, color: Colors.white),
                  label: 'Location',
                ),
                NavigationDestination(
                  icon: Icon(Icons.chat_bubble, color: Colors.grey),
                  selectedIcon: Icon(Icons.chat_bubble, color: Colors.white),
                  label: 'Chat',
                ),
                NavigationDestination(
                  icon: Icon(Icons.camera_alt, color: Colors.grey),
                  selectedIcon: Icon(Icons.camera_alt, color: Colors.white),
                  label: 'Snap',
                ),
                NavigationDestination(
                  icon: Icon(Icons.play_circle_outline, color: Colors.grey),
                  selectedIcon:
                      Icon(Icons.play_circle_outline, color: Colors.white),
                  label: 'Stories',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person, color: Colors.grey),
                  selectedIcon: Icon(Icons.person, color: Colors.white),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }
}
