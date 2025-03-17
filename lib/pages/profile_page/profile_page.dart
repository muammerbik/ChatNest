import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:chat_menager/views/profile_page_view/view/profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => SignUpBloc(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == SignUpStatus.init ||
                      state.status == SignUpStatus.loading) {
                    return const LoadingPageView();
                  } else if (state.status == SignUpStatus.success) {
                    return ProfilePageView();
                  } else if (state.status == SignUpStatus.error) {
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
