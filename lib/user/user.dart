import 'package:cloud_firestore/cloud_firestore.dart';

/// User model
///
/// This is the user model class that will be used to manage the user's data.
///
/// [private] is the private field that will be used to store the user's data.
class User {
  String uid;
  String? name;
  String? gender;

  CollectionReference col = FirebaseFirestore.instance.collection('users');
  DocumentReference get doc => col.doc(uid);

  User({
    required this.uid,
    this.name,
    this.gender,
  });

  /// Create a user with the given [uid].
  ///
  /// This is a factory constructor that will be used to create a user with the
  /// given [uid]. Be sure that the other fields are  empty(or null) even if
  /// they are not empty(or null) in the database.
  ///
  /// Use this when you need to use the method of the user model class. And do
  /// not use the fields of the user model class.
  factory User.fromUid(String uid) {
    return User(
      uid: uid,
    );
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return User(
      uid: snapshot.id,
      name: data['name'],
      gender: data['gender'],
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    return data;
  }

  /// Deprecated
  ///
  /// Don't use create method. It's not for creating a user.
  ///
  /// Use update method instead to create user data.
  @Deprecated('This is not for use.')
  static create({
    required String uid,
  }) {}

  Future update() async {
    await doc.set({'name': name}, SetOptions(merge: true));
  }

  Future updateOnAuthStateChange() async {
    await doc.set(
      {
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
