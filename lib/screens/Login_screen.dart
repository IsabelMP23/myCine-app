import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycine_app/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
            body: SignInScreen(
              providers: [EmailAuthProvider()],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/img/logo.png'),
                  ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: action == AuthAction.signIn
                        ? const Text('Inicia sesión para continuar')
                        : const Text('Crea una cuenta para continuar'));
              },
              footerBuilder: (context, action) {
                return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Al iniciar sesión, acepta nuestros Términos de servicio y Política de privacidad',
                      style: TextStyle(color: Colors.grey),
                    ));
              },
              sideBuilder: (context, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/img/logo.png'),
                  ),
                );
              },
            ),
          );
        }

        return MyHomePage();
      },
    );
  }
}
