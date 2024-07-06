import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_house/model_house.dart';
import 'package:rxdart/rxdart.dart';

bool get isRootAdmin =>
    AdminService.instance.admins?[my!.uid]?.contains('root') ?? false;

bool get isAdmin =>
    AdminService.instance.admins?.keys.contains(my!.uid) ?? false;

/// AdminService
///
///
class AdminService {
  static AdminService? _instance;
  static AdminService get instance => _instance ??= AdminService();

  DocumentReference get adminDoc =>
      FirebaseFirestore.instance.collection('settings').doc('admins');

  /// 관리자 정보를 담는 변수.
  Map<String, List<String>>? admins;

  /// 관리자 정보가 변경될 때 알림을 받는 스트림.
  BehaviorSubject<Map<String, List<String>>?> adminChange =
      BehaviorSubject.seeded(null);

  bool initialized = false;

  /// Initialize the AdminService
  init() {
    initialized = true;

    print('init admin service; initialized: $initialized');

    /// 관리자 목록 문서 구독.
    ///
    /// 메모리에 관리자 목록을 보관해서, 매번 서버에 요청하지 않도록 한다.
    /// 앱 시작시 한번 구독하면, 앱 종료할 때까지 필요하므로, 해제를 할 필요가 없다.
    adminDoc.snapshots().listen((event) {
      if (event.exists == false) {
        admins = null;
        adminChange.add(null);
        return;
      }
      final data = event.data() as Map;
      admins = data.map(
        (key, value) => MapEntry(
          key as String,
          List<String>.from(value as List),
        ),
      );
      print('adminChange.add(admins); $admins');
      adminChange.add(admins);
    });
  }

  /// Claim the login user as root admin.
  ///
  ///
  Future<void> claimAsRoot() async {
    await adminDoc.set({
      my!.uid: ['root'],
    });
  }

  /// Get all admins in /settings/admins document.
  ///
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
