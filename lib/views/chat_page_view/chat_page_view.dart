import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/components/dialog/custom_alert_dialog.dart';
import 'package:chat_menager/components/navigation_helper/navigation_halper.dart';
import 'package:chat_menager/constants/app_strings.dart';
import 'package:chat_menager/views/empty_page_view/empty_page_view.dart';
import 'package:chat_menager/views/loading_page_view/loading_page.dart';
import 'package:chat_menager/views/message_page_view/message_page_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:intl/intl.dart';

class ChatPageView extends StatefulWidget {
  const ChatPageView({
    super.key,
  });

  @override
  State<ChatPageView> createState() => _ChatPageViewState();
}

class _ChatPageViewState extends State<ChatPageView>
    with WidgetsBindingObserver {
  late final String currentUserId;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    currentUserId = context.read<SignUpBloc>().state.userModel.userId;
    debugPrint("ChatPageView - Current User ID: $currentUserId");
    _refreshChatList();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshChatList();
    }
  }

  void _refreshChatList() {
    context.read<ChatBloc>().add(
          GetAllConversationsEvent(userId: currentUserId),
        );
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
              appBarTitle: isSearching ? '' : chats,
              customTitle: isSearching
                  ? SizedBox(
                      height: 40.h,
                      child: TextField(
                        autofocus: true,
                        controller:
                            context.read<ChatBloc>().state.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search chat...',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 16),
                        onChanged: (value) {
                          context
                              .read<ChatBloc>()
                              .add(const SearchConversationsEvent());
                        },
                      ),
                    )
                  : null,
              actionIcons: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                      if (!isSearching) {
                        context.read<ChatBloc>().state.searchController.clear();
                        context
                            .read<ChatBloc>()
                            .add(const SearchConversationsEvent());
                      }
                    });
                  },
                  icon: Icon(
                    isSearching ? Icons.close : Icons.search,
                    color: black,
                  ),
                ),
              ],
            ),
            body: state.chatList.isEmpty
                ? EmptyPageView(
                    message: chatsEmptyPageText,
                  )
                : isSearching && state.searchList.isEmpty
                    ? EmptyPageView(
                        message: 'No chats found matching your search',
                      )
                    : ListView.builder(
                        itemCount:
                            (isSearching ? state.searchList : state.chatList)
                                .length,
                        itemBuilder: (context, index) {
                          final chat = (isSearching
                              ? state.searchList
                              : state.chatList)[index];
                          return GestureDetector(
                            onLongPress: () {
                              showCupertinoDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return CustomCupertinoAlertDialog(
                                    title: deleteChatTitle,
                                    content: deleteChatSubTitle,
                                    noButtonOnTap: () {
                                      Navigation.ofPop();
                                    },
                                    noButtonText: cancel,
                                    yesButtonOnTap: () {
                                      context.read<ChatBloc>().add(
                                            ChatDeleteEvent(
                                              currentUserId: currentUserId,
                                              chattedUserId: chat.talkingTo,
                                            ),
                                          );
                                      Navigator.pop(context);
                                      _refreshChatList();
                                    },
                                    yesButtonText: ok,
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: chat.talkingToUserProfileUrl!.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor: grey.withAlpha(30),
                                      backgroundImage: NetworkImage(
                                          chat.talkingToUserProfileUrl!),
                                    )
                                  : CircleAvatar(
                                      radius: 24.r,
                                      backgroundColor: grey.withAlpha(30),
                                      backgroundImage: AssetImage(userImage),
                                    ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidgets(
                                    text: _getShortenedText(
                                        chat.talkingToUserName!, 28),
                                    size: 16.sp,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidgets(
                                    text: _formatTime(chat.createdAt),
                                    size: 12.sp,
                                    textAlign: TextAlign.end,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              subtitle: TextWidgets(
                                text:
                                    _getShortenedText(chat.lastSentMessage, 36),
                                size: 14.sp,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.normal,
                              ),
                              onTap: () async {
                                final currentUser =
                                    context.read<SignUpBloc>().state.userModel;
                                await Navigation.push(
                                  page: MessagePageView(
                                    currentUser: currentUser,
                                    chattedUser: UserModel.withIdAndProfileUrl(
                                        userId: chat.talkingTo,
                                        profileUrl:
                                            chat.talkingToUserProfileUrl,
                                        userName: chat.talkingToUserName),
                                  ),
                                );
                                _refreshChatList();
                              },
                            ),
                          );
                        },
                      ),
          );
        }
      },
    );
  }

  String _formatTime(Timestamp timestamp) {
    final now = DateTime.now();
    final date = timestamp.toDate();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      // Today - show time
      return DateFormat('HH:mm').format(date);
    } else if (diff.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      // Within a week - show day name
      return DateFormat('EEEE').format(date);
    } else {
      // Older - show date
      return DateFormat('dd/MM/yy').format(date);
    }
  }

  String _getShortenedText(String text, int maxLength) {
    return text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;
  }
}
