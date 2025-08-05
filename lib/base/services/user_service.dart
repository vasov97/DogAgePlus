import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dog_age_plus/base/models/user.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    await _users.doc(user.id).set(user.toMap());
  }

  Future<UserModel?> getUserById(String id) async {
    final doc = await _users.doc(id).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _users.get();
    return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
  }

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await _users.doc(id).update(data);
  }

  Future<void> deleteUser(String id) async {
    await _users.doc(id).delete();
  }

  Stream<UserModel?> streamUser(String id) {
    return _users.doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromMap(doc.data()!);
    });
  }

  Stream<List<UserModel>> streamAllUsers() {
    return _users.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList(),
    );
  }
}
