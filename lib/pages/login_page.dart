import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcrud/components/my_button.dart';
import 'package:testcrud/services/auth/auth_service.dart';
import '../components/my_text_fields.dart';


class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in user
  Future<void> signIn () async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailPassword(
          emailController.text,
          passwordController.text
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                e.toString(),
              ),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.message,
                  size: 80,
                ),
                const SizedBox(height: 20),

                // Welcome message
                const Text(
                  "Welcome to My App",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                // Email text field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Password text field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Sign in button
                MyButton(
                  onTap: signIn,
                  text: 'Sign In',
                ),


                const SizedBox(height: 25),
                // Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

