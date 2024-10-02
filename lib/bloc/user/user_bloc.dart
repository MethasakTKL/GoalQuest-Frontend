import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/models/models.dart';
import 'package:goal_quest/repositories/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final List<UserModel> emptyUserList = [];

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUserEvent>(_onLoadUser);
    on<CreateUserEvent>(_onCreateUser);
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<ChangePasswordEvent>(_onChangePassword);
    on<GetAllUsersEvent>(_onGetAllUsers);
  }

  _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async {
    if (state is UserSuccess) {
      try {
        final user = await userRepository.getMeUser();
        debugPrint("loadsuccess: ${user.toString()}");
        emit(ReadyUserState(user: user));
      } catch (e) {
        debugPrint("loadfaile: ${e.toString()}");
        emit(UserFailure(error: e.toString()));
      }
    }
  }

  _onCreateUser(CreateUserEvent event, Emitter<UserState> emit) async {
    if (state is UserInitial) {
      try {
        final response = await userRepository.createUser(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        );
        emit(UserCreated(message: response));
      } catch (e) {
        emit(UserFailure(error: e.toString()));
      }
    }
  }

  _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await userRepository.loginUser(
        username: event.username,
        password: event.password,
      );
      debugPrint("username: ${event.username}");
      debugPrint("password: ${event.password}");
      emit(UserSuccess(message: 'User Login successfully'));
      add(LoadUserEvent());
    } catch (e) {
      debugPrint("loginfaile: ${e.toString()}");
      emit(UserFailure(error: e.toString()));
    }
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading()); // แสดงสถานะโหลด
    try {
      await userRepository.logoutUser();
      emit(UserInitial()); // ส่งสถานะเริ่มต้นหลังจากออกจากระบบ
    } catch (e) {
      emit(UserFailure(error: e.toString())); // ส่งข้อผิดพลาด
    }
  }

  _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    if (state is  AllUsersLoaded) {
      try {
        await userRepository.updateUser(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
        );
        final updatedUser = await userRepository.getMeUser();

        emit(ReadyUserState(user: updatedUser));
        emit(UserSuccess(message: 'User updated successfully'));
        add(LoadUserEvent());
      } catch (e) {
        emit(UserFailure(error: e.toString()));
      }
    }
  }

  _onChangePassword(ChangePasswordEvent event, Emitter<UserState> emit) async {
    if (state is AllUsersLoaded) {
      try {
        await userRepository.updatePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );
        final updatedUser = await userRepository.getMeUser();
        emit(ReadyUserState(user: updatedUser));
        emit(UserSuccess(message: 'Password changed successfully'));
        add(LoadUserEvent());
      } catch (e) {
        emit(UserFailure(error: e.toString()));
      }
    }
  }

  _onGetAllUsers(GetAllUsersEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      try {
        final users = await userRepository.getAllUsers();
        final currentUser = (state as ReadyUserState)
            .user; // รับข้อมูลผู้ใช้ที่ล็อกอินอยู่จาก state ปัจจุบัน

        // ส่งข้อมูลผู้ใช้ที่ล็อกอินอยู่ (user) และผู้ใช้ทั้งหมด (usersList)
        emit(AllUsersLoaded(user: currentUser, usersList: users));
      } catch (e) {
        emit(UserFailure(error: e.toString()));
      }
    }
  }
}
