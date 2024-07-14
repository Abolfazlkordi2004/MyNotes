import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/loginview.dart';
import 'package:mynotes/views/registerview.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Notesview(),
      routes: {
        '/register/': (context) => const registerview(),
        '/Login/': (context) => const Loginview()
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text('Regsiter'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(hintText: 'Enter a email here'),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter a password here '),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              final userCreditinol =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
              print(userCreditinol);
            },
            child: Text('Register'),
          )
        ],
      ),
    );
  }
}

class Notesview extends StatefulWidget {
  const Notesview({super.key});

  @override
  State<Notesview> createState() => _NotesviewState();
}

enum menuAction { logout }

class _NotesviewState extends State<Notesview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu item'),
        actions: [
          PopupMenuButton<menuAction>(
            onSelected: (value) async {
              switch (value) {
                case menuAction.logout:
                  final showUser = await ShowLogOutDialog(context);
                  if (showUser) {
                    await FirebaseAuth.instance.signOut();
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: menuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
    );
  }
}

Future<bool> ShowLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Sign out'),
        content: Text('Are you sure sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/Login/',
                (_) => false,
              );
            },
            child: Text('Sign out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
