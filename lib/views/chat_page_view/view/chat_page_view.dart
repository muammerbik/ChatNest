import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({super.key});

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarView(
        appBarTitle: 'Sohbetler',
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
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MessagePageView(),
            ));
          },
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidgets(
                      text: "Muammer",
                      size: 16.sp,
                      textAlign: TextAlign.start,
                    ),
                    TextWidgets(
                      text: "12:25",
                      size: 12.sp,
                      textAlign: TextAlign.end,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
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
      ),
    );
  }
}
