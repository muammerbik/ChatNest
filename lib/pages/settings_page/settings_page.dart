import 'package:chat_menager/bloc/settings_bloc/settings_bloc.dart';
import 'package:chat_menager/views/empty_page_view.dart';
import 'package:chat_menager/views/loading_page.dart';
import 'package:chat_menager/views/settings_page_view/view/settings_page-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.sizeOf(context).height;
    final _width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: _height,
        width: _width,
        child: BlocProvider(
          create: (context) => SettingsBloc(),
          child: Builder(
            builder: (context) {
              return BlocConsumer<SettingsBloc, SettingsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == SettingsStatus.init ||
                      state.status == SettingsStatus.loading) {
                    return const LoadingPageView();
                  } else if (state.status == SettingsStatus.success) {
                    return SettingsPageView();
                  } else if (state.status == SettingsStatus.error) {
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
