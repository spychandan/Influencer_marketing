
import 'package:appcreasip/screens/dashboard_screen.dart';
import 'package:appcreasip/screens/home_screen.dart';
import 'package:appcreasip/screens/signup_screen.dart';
import 'package:appcreasip/screens/switch_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../util/consts/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
   int _selectedIndex = 0;

  static List<Widget> _screens = [
    DashboardScreen(),
    HomeScreen(),
    SwitchSelection(),
    SignUpScreen(),
  ];
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        //showUnselectedLabels: true,
        currentIndex: _selectedIndex, 
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
            BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Cafe Collabs',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Influencer Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Training',
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}