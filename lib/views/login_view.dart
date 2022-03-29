import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants/routes.dart';
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Giriş Yap'),
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
          Center(
            child: Row(
              children: [
                Center(
                  child: TextButton(
                      onPressed: () async {
                        //    final user = FirebaseAuth.instance.currentUser;
                        //     await user?.sendEmailVerification();
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            notesroute,
                            (route) => false,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            await showErrorDialog(
                              context,
                              'Kullanıcı Bulunamadı',
                            );
                          } else if (e.code == 'wrong-password') {
                            await showErrorDialog(
                              context,
                              'yanlış şifre',
                            );
                          } else {
                            await showErrorDialog(
                              context,
                              'hata: ${e.code}',
                            );
                          }
                        } catch (e) {
                          await showErrorDialog(
                            context,
                            e.toString(),
                          );
                        }
                      },
                      child: const Text('Giriş yap!')),
                ),
                Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registerroute,
                            (route) => false,
                          );
                        },
                        child: const Text('Hesabın yok mu? Üye ol!'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
