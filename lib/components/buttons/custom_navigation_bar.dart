import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomBarNavigation extends StatelessWidget {
  const CustomBottomBarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      unselectedLabelStyle: GoogleFonts.comfortaa(
        color: Colors.black,
        fontSize: 10,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      selectedLabelStyle: GoogleFonts.comfortaa(
        color: Colors.black,
        fontSize: 10,
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
      elevation: 0,
      onTap: (i) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBar(
              routeIndex: i,
            ),
          ),
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
            color: Colors.black,
            size: 22,
          ),
          label: "Kullanıcılar",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: Colors.black,
            size: 22,
          ),
          label: "Sohbetler",
        ),
         BottomNavigationBarItem(
          icon: Icon(
           Icons.manage_accounts,
            color: Colors.black,
            size: 22,
          ),
          label: "Profil",
        ),
      ],
    );
  }
}
