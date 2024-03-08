import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_text_fields.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
    });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signup () async {
    //sign up user
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password do not match"),
        ),
      );
      return;
    }

    //get auth service
     final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpwithEmailandPasswaord(
          emailController.text,
          passwordController.text
      );
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()),
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

                // Create Account
                const Text(
                  "Let's create an account for you",
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

                // Confirm Password text field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),

                // Sign up button
                MyButton(
                  onTap: signup,
                  text: 'Sign Up',
                ),


                const SizedBox(height: 25),

                // Already a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already a member?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Login now',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
