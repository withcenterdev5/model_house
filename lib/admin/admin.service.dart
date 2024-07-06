import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_house/model_house.dart';

class AdminService {
  static AdminService? _instance;
  static AdminService get instance => _instance ??= AdminService();

  DocumentReference get adminDoc =>
      FirebaseFirestore.instance.collection('settings').doc('admins');

  /// Claim the login user as root admin.
  ///
  ///
  Future<void> claimAsRoot() async {
    await adminDoc.set({
      my!.uid: ['root'],
    });
  }
}
