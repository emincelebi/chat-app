import 'package:flutter/material.dart';
import 'package:message_app/services/auth/auth_services.dart';
import 'package:message_app/widgets/my_button.dart';
import 'package:message_app/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
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
                  'Welcome!',
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
                const SizedBox(height: 30),
                MyButton(onTap: signIn, text: 'Sign in'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    TextButton(
                        onPressed: widget.onTap,
                        child: const Text(
                          'register now',
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
