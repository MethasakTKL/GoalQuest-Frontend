sealed class UserEvent {}

class LoadUserEvent extends UserEvent {}

class CreateUserEvent extends UserEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  CreateUserEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

class LoginUserEvent extends UserEvent {
  final String username;
  final String password;
  LoginUserEvent({
    required this.username,
    required this.password,
  });
}

class LogoutUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String username;
  final String firstName;
  final String lastName;
  final String email;

  UpdateUserEvent({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class ChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;
  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}

class GetAllUsersEvent extends UserEvent {}
