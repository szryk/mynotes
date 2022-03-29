import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:project1/constants/routes.dart';

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
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  devtools.log('verified');
                } else {}
              } else {
                await user?.sendEmailVerification();
              }
            },
            child: const Text("'Buton'"),
          ),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
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
