import 'dart:developer';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/chat_page_view/chat_page_view.dart';
import 'package:chat_menager/views/home_page_view/home_page_view.dart';
import 'package:chat_menager/views/profile_page_view/view/profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBar extends StatefulWidget {
  final int? routeIndex;
  const BottomBar({super.key, this.routeIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  bool sendStory = false;

  final List<Widget> _widgetOptions = <Widget>[
    HomePageView(),
    ChatPageView(),
    const ProfilePageView(),
  ];

  @override
  void initState() {
    if (widget.routeIndex != null) {
      setState(() {
        _selectedIndex = (widget.routeIndex)!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        selectedIconTheme: IconThemeData(color: customRed),
        selectedItemColor: customRed,
        unselectedItemColor: Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        unselectedLabelStyle: GoogleFonts.comfortaa(
          color: Colors.black,
          fontSize: 10,
          textStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        selectedLabelStyle: GoogleFonts.comfortaa(
          color: customRed,
          fontSize: 12,
          textStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (i) async {
          setState(() {
            _selectedIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Icon(
                    Icons.group,
                    color: customRed,
                    size: 22,
                  )
                : Icon(
                    Icons.group,
                    color: black,
                    size: 22,
                  ),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(
                    Icons.chat,
                    color: customRed,
                    size: 22,
                  )
                : Icon(
                    Icons.chat,
                    color: black,
                    size: 22,
                  ),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(
                    Icons.manage_accounts,
                    color: customRed,
                    size: 22,
                  )
                : Icon(
                    Icons.manage_accounts,
                    color: black,
                    size: 22,
                  ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
