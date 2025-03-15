import 'package:chat_menager/bloc/chat_bloc/chat_bloc.dart';
import 'package:chat_menager/bloc/chat_bloc/chat_state.dart';
import 'package:chat_menager/views/chat_page_view/view/chat_page_view.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => ChatBloc(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<ChatBloc, ChatState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == ChatStatus.init ||
                      state.status == ChatStatus.loading) {
                    return const LoadingPageView();
                  } else if (state.status == ChatStatus.success) {
                    return ChatPageView(
                      chatList: state.chatList,
                    );
                  } else if (state.status == ChatStatus.error) {
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
