import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // State değişikliklerini dinle (isteğe bağlı)
        },
        builder: (context, state) {
          if (state.chatList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: state.chatList.length,
            itemBuilder: (context, index) {
              final chat = state.chatList[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.grey.withAlpha(30),
                  backgroundImage: NetworkImage(chat.konusulanUserProfilUrl ??
                      "https://thumbs.dreamstime.com/b/macho-avec-le-regard-s%C3%A9v%C3%A8re-et-les-poils-du-visage-s%C3%A9rieux-concept-de-la-masculinit%C3%A9-confiance-l-homme-aux-cheveux-justes-sur-170135364.jpg"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidgets(
                      text: chat.konusulanUserName!,
                      size: 16.sp,
                      textAlign: TextAlign.start,
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
                  text: chat.son_yollanan_mesaj,
                  size: 14.sp,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.normal,
                ),
                onTap: () {
                   final currentUser = context.read<SignUpBloc>().state.userModel;
                   final messageBloc = context.read<MessageBloc>();
                   Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MessagePageView(
                              currentUser: currentUser,
                              sohbetEdilenUser: UserModel.withIdAndProfileUrl(
                                  userName: chat.konusulanUserName,
                                  userId: chat.kimle_konusuyor,
                                  profileUrl: chat.konusulanUserProfilUrl),
                            ),
                          ),
                        );
                   messageBloc.add(GetMessageEvent(
                     currentUserId: currentUser.userId,
                     sohbetEdilenUserId: chat.kimle_konusuyor,
                   ));
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final currentUserId = context.read<SignUpBloc>().state.userModel.userId;
    Future.microtask(() => context
        .read<ChatBloc>()
        .add(GetAllConversationsEvent(userId: currentUserId)));
  }
}
