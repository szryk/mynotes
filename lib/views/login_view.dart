import 'package:flutter/material.dart';
import 'package:project1/constants/routes.dart';
import 'package:project1/services/auth/auth_expections.dart';
import 'package:project1/services/auth/auth_service.dart';
import 'package:project1/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Mail',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Şifre',
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      // user's email is verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesroute,
                        (route) => false,
                      );
                    } else {
                      // user's email is NOT verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        veriffyEmailRoute,
                        (route) => false,
                      );
                    }
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'Kullanıcı Bulunamadı',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Yanlış Şifre',
                    );
                  } on GenericAuthExpection {
                    await showErrorDialog(
                      context,
                      'Doğrulama hatası!',
                    );
                  }
                },
                child: const Text('giriş'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerroute,
                    (route) => false,
                  );
                },
                child: const Text(' Burdan kayıt olabilirsin.'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
