import 'package:flutter/material.dart';
import 'package:hotel_app/features/chats.dart';
import 'package:hotel_app/features/favorite.dart';
import 'package:hotel_app/features/homepage.dart';
import 'features/profile/login.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int bottomNavIndex = 0;
  bool isLoggedIn = true; // Added to manage login state

  void _handleLoginSuccess() {
    setState(() {
      isLoggedIn = true; // Update the login state to true on successful login
      bottomNavIndex = 3; // Switch to the profile page after login
    });
  }

  @override
  Widget build(BuildContext context) {
    Color mycolor = Colors.black;
    return Scaffold(
      body:bottomnavBody(bottomNavIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: mycolor),
            icon: Icon(Icons.home_outlined, color: mycolor),
            label: 'home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite, color: mycolor),
            icon: Icon(Icons.favorite_border, color: mycolor),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.chat_bubble, color: mycolor),
            icon: Icon(Icons.chat_bubble_outline, color: mycolor),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_circle_rounded, color: mycolor),
            icon: Icon(Icons.account_circle_outlined, color: mycolor),
            label: 'profile',
          ),
        ],
        currentIndex: bottomNavIndex,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
          });
        },
      )
         
    );
  }

  Widget bottomnavBody(int bottomNavIndex) {
    switch (bottomNavIndex) {
      case 0:
        return Homepage();
      case 1:
        return Favorite();
      case 2:
        return Chats();
      default:
        return LoginPage();
    }
  }
}
