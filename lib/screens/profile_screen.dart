import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      actions: [
      SignedOutAction((context) {
        Navigator.pushReplacementNamed(context, '/');
      }),
    ]);
  }
}
