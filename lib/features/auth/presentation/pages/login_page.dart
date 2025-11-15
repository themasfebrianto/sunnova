import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunnova_app/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:sunnova_app/features/auth/presentation/pages/register_page.dart';
import 'package:sunnova_app/features/home/presentation/pages/home_page.dart';
import 'package:sunnova_app/features/auth/presentation/widgets/auth_text_field.dart';

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
      await authNotifier.login(
        _emailController.text,
        _passwordController.text,
      );

      if (authNotifier.state.status == AuthStatus.authenticated) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else if (authNotifier.state.errorMessage != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authNotifier.state.errorMessage!)),
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
                AuthTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Consumer<AuthNotifier>(
                  builder: (context, authNotifier, child) {
                    return ElevatedButton(
                      onPressed: authNotifier.state.status == AuthStatus.authenticating ? null : _login,
                      child: authNotifier.state.status == AuthStatus.authenticating
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Login'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
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
