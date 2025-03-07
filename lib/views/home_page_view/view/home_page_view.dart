import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarView(
        appBarTitle: 'Kullanıcılar',
        centerTitle: false,
        textColor: Colors.black,
        actionIcons: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.withAlpha(30),
                backgroundImage: NetworkImage(
                    "https://thumbs.dreamstime.com/b/macho-avec-le-regard-s%C3%A9v%C3%A8re-et-les-poils-du-visage-s%C3%A9rieux-concept-de-la-masculinit%C3%A9-confiance-l-homme-aux-cheveux-justes-sur-170135364.jpg"),
              ),
              title: TextWidgets(
                text: "Muammer",
                size: 16.sp,
                textAlign: TextAlign.start,
              ),
              subtitle: TextWidgets(
                text: "Bugün Xcode kuralım, olur mu ?",
                size: 14.sp,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.normal,
              ),
            );
          },
        ),
      ),
    );
  }
}
