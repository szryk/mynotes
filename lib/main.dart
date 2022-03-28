import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/views/login_view.dart';
import 'package:project1/views/register_view.dart';
import 'package:project1/views/verify_email_view.dart';
import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Not Defteri',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  print('verified');
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

              return const NotesView();
            default:
              return const CircularProgressIndicator();
            //  final emailverified = user?.emailVerified ?? false;
            // print(user);
            //  if (emailverified == true) {

            //  } else {
            //    return const VerifyEmailView();
            //  }

          }
        });
  }
}

enum MenuActions { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Menü'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<MenuActions>(
            onSelected: (value) async {
              switch (value) {
                case MenuActions.logout:
                  final shouldlogout = await ShowLogOutDialog(context);
                  if (shouldlogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuActions>(
                  value: MenuActions.logout,
                  child: Text('çıkış yap'),
                )
              ];
            },
          )
        ],
      ),
      body: const Text('Merhaba Dünya'),
      backgroundColor: Colors.grey,
    );
  }
}

Future<bool> ShowLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Çıkış yap'),
        content: const Text('Emin misin?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('hayır')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('evet'))
        ],
      );
    },
  ).then((value) => value ?? false);
}
