import 'package:goal_quest/models/models.dart';

sealed class UserState {
  final UserModel user;
  final String error;
  final String message;
  final List<UserModel> usersList;

  UserState({required this.user, this.error = ' ', this.message = ' ', this.usersList = const [] });
}

class UserInitial extends UserState {
  UserInitial() : super(user: UserModel.empty());
}

class UserLoading extends UserState {
  UserLoading() : super(user: UserModel.empty());
}

class UserCreated extends UserState {
  UserCreated({required super.message}) : super(user: UserModel.empty());
}

class UserSuccess extends UserState {
  UserSuccess({required super.message}) : super(user: UserModel.empty());
}

class UserFailure extends UserState {
  UserFailure({required super.error}) : super(user: UserModel.empty());
}

class ReadyUserState extends UserState {
  ReadyUserState({required super.user, super.usersList});
}

// const List<UserModel> emptyUserList = [];

class AllUsersLoaded extends UserState {
  
  AllUsersLoaded({required super.user, required super.usersList});
}


