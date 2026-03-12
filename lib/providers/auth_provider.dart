import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  Future<void> login(String username, String password) async {
    // จำลองการ login
    await Future.delayed(const Duration(seconds: 1));
  }

  void logout() {}

}