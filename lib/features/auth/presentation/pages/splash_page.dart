import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/auth/presentation/pages/login_page.dart';
import 'package:sunnova_app/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, you would check SharedPreferences or a secure storage
    // to see if a user token exists or if the user is already logged in.
    // For now, we'll simulate a logged-out state.
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    // Assuming authNotifier has a method to check initial login status
    // await authNotifier.checkInitialLogin();

    if (!mounted) return;

    if (authNotifier.state.status == AuthStatus.authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your Sunnova logo
            Image.asset(
              'assets/images/sunnova_logo.png', // Make sure you have a logo in assets/images
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              'Loading Sunnova App...',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}