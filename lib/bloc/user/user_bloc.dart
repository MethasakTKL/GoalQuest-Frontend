import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/repositories/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(UserInitial()){
    on<LoadUserEvent>(_onLoadUser);
    on<CreateUserEvent>(_onCreateUser);
    on<LoginUserEvent>(_onLoginUser);
    on<LogoutUserEvent>(_onLogoutUser);
  }

  _onLoadUser(LoadUserEvent event, Emitter<UserState> emit) async{
    if (state is UserLoginSuccess){
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


  _onCreateUser(CreateUserEvent event, Emitter<UserState> emit) async{
    if (state is UserInitial){
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
        


  _onLoginUser(LoginUserEvent event, Emitter<UserState> emit) async{
    emit(UserLoading());
    try {
      await userRepository.loginUser(
        username: event.username,
        password: event.password,
      );
      debugPrint("username: ${event.username}");
      debugPrint("password: ${event.password}");
      emit(UserLoginSuccess());
      add(LoadUserEvent());
    } catch (e) {
      debugPrint("loginfaile: ${e.toString()}");
      emit(UserFailure(error: e.toString()));
    }
  }

  _onLogoutUser(LogoutUserEvent event, Emitter<UserState> emit) async{
    emit(UserLoading()); // แสดงสถานะโหลด
    try {
      await userRepository.logoutUser();
        emit(UserInitial()); // ส่งสถานะเริ่มต้นหลังจากออกจากระบบ
  } catch (e) {
    emit(UserFailure(error: e.toString())); // ส่งข้อผิดพลาด
    }
  }
}



