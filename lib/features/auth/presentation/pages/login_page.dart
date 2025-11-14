import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For temporary login
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/auth/presentation/pages/register_page.dart';
import 'package:sunnova_app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:sunnova_app/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      await authNotifier.login(_emailController.text, _passwordController.text);

      if (authNotifier.state.status == AuthStatus.authenticated) {
        // Save user ID to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'currentUserId',
          authNotifier.state.user!.uid,
        ); // Save the actual UID

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else if (authNotifier.state.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authNotifier.state.errorMessage ?? 'Login Failed'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // Removed const
                  'Welcome Back!',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge, // Use theme typography
                ),
                const SizedBox(height: 40),
                AuthTextField(
                  labelText: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AuthTextField(
                  labelText: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Consumer<AuthNotifier>(
                  builder: (context, authNotifier, child) {
                    return ElevatedButton(
                      onPressed: authNotifier.state.status == AuthStatus.loading
                          ? null
                          : _login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ), // Full width button
                      ),
                      child: authNotifier.state.status == AuthStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Login'),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('Don\'t have an account? Register here.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
