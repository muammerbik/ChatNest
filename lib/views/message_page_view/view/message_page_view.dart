import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/components/custom_textFormField/custom_textForm_Field.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/material.dart';

class MessagePageView extends StatefulWidget {
  const MessagePageView({
    super.key,
  });

  @override
  State<MessagePageView> createState() => _MessagePageViewState();
}

class _MessagePageViewState extends State<MessagePageView> {
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Map<String, String>> messages = [
    {
      "sender": "currentUser",
      "message": "Hello, how are you?",
      "time": "12:30"
    },
    {
      "sender": "sohbetEdilenUser",
      "message": "I'm good, thank you!",
      "time": "12:32"
    },
    {
      "sender": "currentUser",
      "message": "Great to hear! What have you been up to?",
      "time": "12:35"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.withAlpha(30),
              backgroundImage: NetworkImage(
                  "https://thumbs.dreamstime.com/b/macho-avec-le-regard-s%C3%A9v%C3%A8re-et-les-poils-du-visage-s%C3%A9rieux-concept-de-la-masculinit%C3%A9-confiance-l-homme-aux-cheveux-justes-sur-170135364.jpg"),
            ),
            SizedBox(
              width: 6,
            ),
            TextWidgets(
              text: "Sevgi Pıtırcığımmm",
              size: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/message_background.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = messages[messages.length - 1 - index];
                  return buildMessageBubble(message);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: 72,
                padding: EdgeInsets.only(bottom: 12, left: 10, top: 12),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                      controller: textEditingController,
                      hintText: 'Mesaj',
                      cursorColor: customDarkGreen,
                    )),
                    Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                        backgroundColor: customDarkGreen,
                        child: const Icon(
                          Icons.navigation,
                          size: 35,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (textEditingController.text.trim().isNotEmpty) {
                            setState(() {
                              messages.add({
                                "sender": "currentUser",
                                "message": textEditingController.text,
                                "time": "12:45"
                              });
                            });
                            textEditingController.clear();
                            _scrollController.animateTo(
                              0, // Scroll to the bottom
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageBubble(Map<String, String> message) {
    bool fromMe = message['sender'] == 'currentUser';
    String timeAndMinuteValue = message['time'] ?? '';

    return Padding(
      padding: EdgeInsets.only(
        left: fromMe ? 45 : 10,
        top: 10,
        right: fromMe ? 10 : 45,
      ),
      child: Column(
        crossAxisAlignment:
            fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!fromMe)
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(
                      "https://thumbs.dreamstime.com/b/macho-avec-le-regard-s%C3%A9v%C3%A8re-et-les-poils-du-visage-s%C3%A9rieux-concept-de-la-masculinit%C3%A9-confiance-l-homme-aux-cheveux-justes-sur-170135364.jpg"),
                ),
              const SizedBox(width: 5),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: fromMe ? customLightGreen : customDarkGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message['message']!,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 4),
                        Text(
                          timeAndMinuteValue,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
