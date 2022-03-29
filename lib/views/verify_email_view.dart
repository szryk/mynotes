import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:project1/constants/routes.dart';
import 'package:project1/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('email onaylama'),
      ),
      body: Column(
        children: [
          const Text('Hesabını doğrulaman için mail gönderdik!'),
          const Text('Eğer mail posta kutuna gelmediyse butona basabilirsin'),
          TextButton(
            onPressed: () async {
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  devtools.log('verified');
                } else {}
              } else {
                await AuthService.firebase().sendEmailVerification();
              }
            },
            child: const Text("'Buton'"),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerroute,
                  (route) => false,
                );
              },
              child: const Text('Mailini yanlış mı girdin?'))
        ],
      ),
    );
  }
}
