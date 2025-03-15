import 'package:chat_menager/bloc/home_bloc/home_bloc.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/home_page_view/view/home_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => HomeBloc(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == HomeStatus.init ||
                      state.status == HomeStatus.loading) {
                    return const LoadingPageView();
                  } else if (state.status == HomeStatus.success) {
                    return HomePageView(
                        allUserList: state.allUserList, hasMore: state.hasMore);
                  } else if (state.status == HomeStatus.error) {
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
