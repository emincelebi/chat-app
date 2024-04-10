import 'package:flutter/material.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/widgets/my_button.dart';
import 'package:message_app/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/message.png')),
                const SizedBox(height: 80),
                const Text(
                  'Register now!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                MyTextField(
                  controller: emailController,
                  obscuretext: false,
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: passwordController,
                  obscuretext: true,
                  hintText: 'Password',
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: confirmPasswordController,
                  obscuretext: true,
                  hintText: 'Confirm the password',
                ),
                const SizedBox(height: 30),
                MyButton(onTap: signUp, text: 'Sign up'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    TextButton(
                        onPressed: widget.onTap,
                        child: const Text(
                          'login',
                          style: TextStyle(color: Colors.black),
                        )),
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
