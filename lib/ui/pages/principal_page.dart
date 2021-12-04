import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_agenda/ui/pages/autenticar_page.dart';
import 'package:flutter_agenda/ui/pages/inicio_page.dart';

// Widget principal
class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const InicioPage();
        } else {
          return const AutenticarPage();
        }
      },
    );
  }
}