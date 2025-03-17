import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/pages/message_page/message_page.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/user_model.dart';

class ChatPageView extends StatefulWidget {
  final List<KonusmaModel> chatList;
  const ChatPageView({
    Key? key,
    required this.chatList,
  }) : super(key: key);

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarView(
        appBarTitle: chats,
        actionIcons: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: black,
            ),
          ),
        ],
      ),
      body: widget.chatList.isNotEmpty
          ? ListView.builder(
              itemCount: widget.chatList.length,
              itemBuilder: (context, index) {
                final chat = widget.chatList[index];
                return ListTile(
                  leading: chat.konusulanUserProfilUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 24.r,
                          backgroundColor: grey.withAlpha(30),
                          backgroundImage:
                              NetworkImage(chat.konusulanUserProfilUrl!),
                        )
                      : CircleAvatar(
                          radius: 24.r,
                          backgroundColor: grey.withAlpha(30),
                          backgroundImage: AssetImage(userImage),
                        ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidgets(
                        text: _getShortenedText(chat.konusulanUserName!, 28),
                        size: 16.sp,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),
                      TextWidgets(
                        text: "12:56",
                        size: 12.sp,
                        textAlign: TextAlign.end,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  subtitle: TextWidgets(
                    text: _getShortenedText(chat.son_yollanan_mesaj, 36),
                    size: 14.sp,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.normal,
                  ),
                  onTap: () {
                    final currentUser =
                        context.read<SignUpBloc>().state.userModel;
                    final messageBloc = context.read<MessageBloc>();

                    Navigation.push(
                        page: MessagePage(
                            currentUser: currentUser,
                            sohbetEdilenUser: UserModel.withIdAndProfileUrl(
                                userId: chat.kimle_konusuyor,
                                userName: chat.konusulanUserName,
                                profileUrl: chat.konusulanUserProfilUrl)));
                    messageBloc.add(
                      GetMessageEvent(
                        currentUserId: currentUser.userId,
                        sohbetEdilenUserId: chat.kimle_konusuyor,
                      ),
                    );
                  },
                );
              },
            )
          : EmptyPageView(
              message: chatsEmptyPageText,
            ),
    );
  }

  String _getShortenedText(String text, int maxLength) {
    return text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;
  }
}
