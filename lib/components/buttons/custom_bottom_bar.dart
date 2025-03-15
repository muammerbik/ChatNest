import 'dart:developer';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/pages/chat_page/chat_page.dart';
import 'package:chat_menager/pages/home_page/home_page.dart';
import 'package:chat_menager/views/chat_page_view/view/chat_page_view.dart';
import 'package:chat_menager/views/home_page_view/view/home_page_view.dart';
import 'package:chat_menager/views/profile_page_view/view/profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
   HomePage(),
   ChatPage(),
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
      backgroundColor: Colors.white,
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
                    color: Colors.black,
                    size: 22,
                  ),
            label: "Kullanıcılar",
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
                    color: Colors.black,
                    size: 22,
                  ),
            label: "Sohbetler",
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
                    color: Colors.black,
                    size: 22,
                  ),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
