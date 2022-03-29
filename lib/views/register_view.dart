import 'package:flutter/material.dart';
import 'package:project1/services/auth/auth_expections.dart';
import 'package:project1/services/auth/auth_service.dart';
import 'package:project1/utilities/show_error_dialog.dart';

import '../constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  // ignore: must_call_super
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
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
        title: const Text('Üye ol'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'E-mail'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Şifre'),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().createUser(
                        email: email,
                        password: password,
                      );
                      final user = AuthService.firebase().currentUser;
                      AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamed(veriffyEmailRoute);
                    } on WeakPasswordAuthExpection {
                      showErrorDialog(
                        context,
                        'Zayıf şifre',
                      );
                    } on EmailAlreadyInUseAuthExpection {
                      await showErrorDialog(
                        context,
                        'email zaten kullanımda',
                      );
                    } on InvalidEmailAuthExpection {
                      await showErrorDialog(
                        context,
                        'Yanlış mail formatı',
                      );
                    } on GenericAuthExpection {
                      await showErrorDialog(
                        context,
                        'bir hata oluştu',
                      );
                    }
                  },
                  child: const Text('Kaydı tamamla!')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginroute,
                      (route) => false,
                    );
                  },
                  child: const Text('Hesabın var mı? Giriş yap!')),
            ],
          ),
        ],
      ),
    );
  }
}
