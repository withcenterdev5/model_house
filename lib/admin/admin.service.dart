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

  /// Get all admins in /settings/admins document.
  Future<Map<String, List<String>>?> getAdmins() async {
    final snapshot = await adminDoc.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map;
      return data.map((key, value) =>
          MapEntry(key as String, List<String>.from(value as List)));
    }
    return null;
  }
}
