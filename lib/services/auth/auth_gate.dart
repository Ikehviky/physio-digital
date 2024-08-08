import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physio_digital/services/auth/login_or_signup.dart';
import 'package:physio_digital/view/home/home_page.dart';
import 'package:physio_digital/view/onbording/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasCompletedOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (authSnapshot.hasData) {
            return HomePage();
          } else {
            return FutureBuilder<bool>(
              future: _hasCompletedOnboarding(),
              builder: (context, onboardingSnapshot) {
                if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (onboardingSnapshot.data == true) {
                  return const LoginOrSignup();
                } else {
                  return const OnboardingPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
