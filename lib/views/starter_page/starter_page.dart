import 'package:chat_menager/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_menager/components/buttons/custom_bottom_bar.dart';
import 'package:chat_menager/views/onboarding_view/onboarding_page_view.dart';
import 'package:chat_menager/views/splash_page_view/splash_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainView(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPageView();
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc()..add(CurrentUserStartEvent()),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          if (state.status == SignUpStatus.loading) {
            return SplashPageView();
          } else if (state.status == SignUpStatus.success) {
            return BottomBar();
          } else {
            return OnboardingPageView();
          }
        },
      ),
    );
  }
}
