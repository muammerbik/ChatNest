import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/empty_page_view/empty_page_view.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/core/model/user_model.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({
    super.key,
  });

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView> {
  @override
  void initState() {
    final currentUserId = context.read<SignUpBloc>().state.userModel.userId;
    debugPrint("ChatPageView - Current User ID: $currentUserId");
    context.read<ChatBloc>().add(
          GetAllConversationsEvent(userId: currentUserId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        debugPrint("ChatPageView - State Status: ${state.status}");
        debugPrint("ChatPageView - Chat List Length: ${state.chatList.length}");
      },
      builder: (context, state) {
        if (state.status == ChatStatus.loading) {
          return LoadingPageView();
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBarView(
              appBarTitle: chats,
              actionIcons: [
                IconButton(
                  onPressed: () {
                    //Arama özelliği eklenecek!
                  },
                  icon: Icon(
                    Icons.search,
                    color: black,
                  ),
                ),
              ],
            ),
            body: state.chatList.isNotEmpty
                ? ListView.builder(
                    itemCount: state.chatList.length,
                    itemBuilder: (context, index) {
                      final chat = state.chatList[index];
                      return ListTile(
                        leading: chat.talkingToUserProfileUrl!.isNotEmpty
                            ? CircleAvatar(
                                radius: 24.r,
                                backgroundColor: grey.withAlpha(30),
                                backgroundImage:
                                    NetworkImage(chat.talkingToUserProfileUrl!),
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
                              text: _getShortenedText(
                                  chat.talkingToUserName!, 28),
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
                          text: _getShortenedText(chat.lastSentMessage, 36),
                          size: 14.sp,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.normal,
                        ),
                        onTap: () {
                          final currentUser =
                              context.read<SignUpBloc>().state.userModel;
                          final messageBloc = context.read<MessageBloc>();

                          Navigation.push(
                            page: MessagePageView(
                              currentUser: currentUser,
                              chattedUser: UserModel.withIdAndProfileUrl(
                                  userId: chat.talkingTo,
                                  profileUrl: chat.talkingToUserProfileUrl,
                                  userName: chat.talkingToUserName),
                            ),
                          );
                          messageBloc.add(
                            GetMessageEvent(
                              currentUserId: currentUser.userId,
                              chattedUserId: chat.talkingTo,
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
      },
    );
  }

  String _getShortenedText(String text, int maxLength) {
    return text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;
  }
}
