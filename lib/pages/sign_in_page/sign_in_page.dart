import 'package:chat_menager/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:chat_menager/views/sign_in_page_view/view/sign_in_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => SignInBloc(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<SignInBloc, SignInState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == SignInStatus.init ||
                      state.status == SignInStatus.loading) {
                    return const LoadingPageView();
                  } else if (state.status == SignInStatus.success) {
                    return SignInPageView();
                  } else if (state.status == SignInStatus.error) {
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
