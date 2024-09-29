import 'package:goal_quest/models/models.dart';

sealed class UserState {
  final UserModel user;
  final String error;
  final String message;

  UserState({required this.user, this.error = ' ', this.message = ' ' });
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
  ReadyUserState({required super.user});
}

const List<UserModel> emptyUserList = [];

class AllUsersLoaded extends UserState {
   final List<UserModel> userList; // Add this line
  
  AllUsersLoaded({required this.userList}) : super(user: UserModel.empty());
}


