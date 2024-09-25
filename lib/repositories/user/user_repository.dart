abstract class UserRepository {
  Future<String> createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<void> loginUser({
    required String username,
    required String password,
  });
  
  Future<void> logoutUser();

  
}