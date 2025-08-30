import 'package:dog_age_plus/base/common_widgets/primary_button.dart';
import 'package:dog_age_plus/features/onboarding/screens/intro_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Your Dog Deserves a Long, Healthy Life',
      'desc':
          'We help you track what really matters — their well-being, every day.',
      'img': 'assets/images/onboarding11.png',
    },
    {
      'title': 'AI-Powered Health Insights',
      'desc':
          'DogAgePlus calculates biological age based on behavior, activity, and care.',
      'img': 'assets/images/onboarding22.png',
    },
    {
      'title': 'You + Dog = Healthy Team',
      'desc':
          'Daily journaling, care tasks, and smart reminders keep both of you on track.',
      'img': 'assets/images/onboarding33.png',
    },
  ];

  void _nextPage() {
    if (_currentPage == _pages.length - 1) {
      // Navigate to login/signup
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return IntroScreen(
                      title: page['title']!,
                      description: page['desc']!,
                      imagePath: page['img']!,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 8),
                child: PrimaryButton(
                  text: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  onPressed: _nextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
