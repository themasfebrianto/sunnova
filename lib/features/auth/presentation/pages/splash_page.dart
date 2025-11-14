import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For temporary login
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/home/presentation/pages/home_page.dart';
import 'package:sunnova_app/features/auth/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('currentUserId');

    Future.delayed(const Duration(seconds: 2), () async { // Made async to await authNotifier call
      if (!mounted) return;

      final authNotifier = Provider.of<AuthNotifier>(context, listen: false);

      if (userId != null && userId.isNotEmpty) {
        await authNotifier.checkUserProfile(userId); // Call the actual use case

        if (authNotifier.state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          // If checkUserProfile fails (e.g., user not found in DB), go to login
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Removed const
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Sunnova Logo - Replace with actual image asset later
            Icon(
              Icons.brightness_5, // Placeholder icon
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 20),
            Text(
              'Sunnova App',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
