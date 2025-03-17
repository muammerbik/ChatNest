// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_menager/bloc/message_bloc/message_bloc.dart';
import 'package:chat_menager/core/model/user_model.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:chat_menager/views/message_page_view/view/message_page_view.dart';

class MessagePage extends StatefulWidget {
  final UserModel currentUser;
  final UserModel sohbetEdilenUser;
  const MessagePage({
    Key? key,
    required this.currentUser,
    required this.sohbetEdilenUser,
  }) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => MessageBloc()
            ..add(GetMessageEvent(
                currentUserId: widget.currentUser.userId,
                sohbetEdilenUserId: widget.sohbetEdilenUser.userId)),
          child: Builder(
            builder: (context) {
              return BlocConsumer<MessageBloc, MessageState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == MessageStatus.init) {
                    return const LoadingPageView();
                  } else if (state.status == MessageStatus.success || 
                             state.status == MessageStatus.loading) {
                    return MessagePageView(
                      currentUser: widget.currentUser,
                      sohbetEdilenUser: widget.sohbetEdilenUser,
                      messageList: state.messageList,
                    );
                  } else if (state.status == MessageStatus.error) {
                    return EmptyPageView();
                  } else {
                    return EmptyPageView();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
