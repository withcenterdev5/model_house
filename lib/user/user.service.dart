import 'package:firebase_auth/firebase_auth.dart';

/// This is the user service class that will be used to manage the user's authentication and user data management.
class UserService {
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();

  UserService._();

  bool get signedIn => FirebaseAuth.instance.currentUser != null;
  bool get notSignedIn => !signedIn;

  Future<void> login(String email, String password) async {
    // Login logic
  }

  Future<void> register(String email, String password) async {
    // Register logic
  }

  Future<void> logout() async {
    // Logout logic
  }
}
