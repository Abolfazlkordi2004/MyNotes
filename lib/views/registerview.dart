import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerview extends StatefulWidget {
  const registerview({super.key});

  @override
  State<registerview> createState() => _LoginviewState();
}

class _LoginviewState extends State<registerview> {
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
            decoration: InputDecoration(hintText: 'Enter a email'),
          ),
          TextField(
            controller: _password,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Enter a password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              final UserCredential = FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);

              print(UserCredential);
            },
            child: Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/Login/',
                (route) => true,
              );
            },
            child: Text('Already have account! login here'),
          )
        ],
      ),
    );
  }
}
