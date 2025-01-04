import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/registre_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegistre extends StatefulWidget {
  const LoginOrRegistre({super.key});

  @override
  State<LoginOrRegistre> createState() => _LoginOrRegistreState();
}

class _LoginOrRegistreState extends State<LoginOrRegistre> {
  bool isLoginPage = true;

  void togglePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginPage) {
      return LoginPage(onTap: togglePage);
    }
    return RegistrePage(
      onTap: togglePage,
    );
  }
}
