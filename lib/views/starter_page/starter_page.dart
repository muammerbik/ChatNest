
import 'package:chat_menager/views/onboarding_view/view/onboarding_page_view.dart';
import 'package:chat_menager/views/splash_page_view/splash_page_view.dart';
import 'package:flutter/material.dart';

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
      Navigator.of(context).push(
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

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPageView();
  }
}
