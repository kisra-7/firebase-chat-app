import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';

class RegistrePage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _conPwcontroller = TextEditingController();
  final void Function()? onTap;
  RegistrePage({super.key, required this.onTap});
  void registre(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _auth = AuthService();
    if (_pwcontroller.text == _conPwcontroller.text) {
      try {
        _auth.signupEmailPassword(_emailcontroller.text, _pwcontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              e.toString(),
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextField(
              hintText: 'Email',
              isObscure: false,
              controller: _emailcontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hintText: 'Password',
              isObscure: true,
              controller: _pwcontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hintText: 'Confirm password',
              isObscure: true,
              controller: _conPwcontroller,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              onTap: () => registre(context),
              text: 'Sign up',
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'All ready have an account?  ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Registre now'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
