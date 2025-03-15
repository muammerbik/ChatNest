// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/custom_appBar/custom_appBar.dart';
import 'package:chat_menager/components/custom_text/custom_text.dart';
import 'package:chat_menager/core/model/konusma_model.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';

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
  void initState() {
    super.initState();
    final currentUserId = context.read<SignUpBloc>().state.userModel.userId;
    Future.microtask(() => context
        .read<ChatBloc>()
        .add(GetAllConversationsEvent(userId: currentUserId)));
  }

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
      body: ListView.builder(
        itemCount: widget.chatList.length,
        itemBuilder: (context, index) {
          final chat = widget.chatList[index];
          return ListTile(
            leading: chat.konusulanUserProfilUrl!.isNotEmpty &&
                    chat.konusulanUserProfilUrl! != null
                ? CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withAlpha(30),
                    backgroundImage: NetworkImage(chat.konusulanUserProfilUrl!),
                  )
                : CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.withAlpha(30),
                    backgroundImage: AssetImage(
                      "assets/icons/user_avatar.png",
                    ),
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
              messageBloc.add(
                GetMessageEvent(
                  currentUserId: currentUser.userId,
                  sohbetEdilenUserId: chat.kimle_konusuyor,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
