import 'package:goal_quest/models/models.dart';

abstract class UserRepository {
  Future<String> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<UserModel> getMeUser();

  Future<void> loginUser({
    required String username,
    required String password,
  });

  Future<void> logoutUser();


  Future<String> updateUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    });

  Future<String> updatePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<List<UserModel>> getAllUsers(
    
  );
  
}