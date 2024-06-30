import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:model_house/model_house.dart';
import 'package:rxdart/rxdart.dart';

/// This is the user service class that will be used to manage the user's authentication and user data management.
class UserService {
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();

  UserService._();

  User? user;
  BehaviorSubject<User?> changes = BehaviorSubject();

  init() {
    listenUserDocumentChanges();
  }

  bool get signedIn => fa.FirebaseAuth.instance.currentUser != null;
  bool get notSignedIn => !signedIn;

  /// Listen to my document
  StreamSubscription<fa.User?>? firebaseAuthSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      firestoreMyDocSubscription;
  listenUserDocumentChanges() {
    firebaseAuthSubscription?.cancel();
    firebaseAuthSubscription =
        fa.FirebaseAuth.instance.authStateChanges().listen((faUser) async {
      /// User state changed
      if (faUser == null) {
        user = null;
      } else {
        /// User signed in. Listen to the user's document changes.
        firestoreMyDocSubscription?.cancel();

        /// User data must be updated first, before listening to the user's
        /// document changes because if the user document does not exist,
        /// the listen will not be triggered.
        /// ! @thruthesky - Dobule check on it!!
        User.fromUid(faUser.uid).updateOnAuthStateChange();
        firestoreMyDocSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(faUser.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.exists) {
            user = User.fromSnapshot(snapshot);
          } else {
            user = null;
          }
          changes.add(user);
        });
      }
    });
  }

  Future<void> signOut() async {
    await fa.FirebaseAuth.instance.signOut();
  }
}
