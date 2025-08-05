import 'package:dog_age_plus/base/models/user.dart';
import 'package:dog_age_plus/base/services/user_service.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Future<void> createUser(UserModel user) => _userService.createUser(user);

  Future<UserModel?> getUserById(String id) => _userService.getUserById(id);

  Future<List<UserModel>> getAllUsers() => _userService.getAllUsers();

  Future<void> updateUser(String id, Map<String, dynamic> data) =>
      _userService.updateUser(id, data);

  Future<void> deleteUser(String id) => _userService.deleteUser(id);

  Stream<UserModel?> streamUser(String id) => _userService.streamUser(id);

  Stream<List<UserModel>> streamAllUsers() => _userService.streamAllUsers();
}
