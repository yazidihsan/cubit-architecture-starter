import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crudmvvm/data/repository/user_repository.dart';
import 'package:crudmvvm/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  UserCubit(this.userRepository) : super(UserInitial());

  void startCreateUser(UserModel user) async {
    try {
      emit(UserLoading());
      final result = await userRepository.createUser(user);

      emit(UserSuccess(users: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }

  void getAllUser() async {
    try {
      emit(UserLoading());
      final result = await userRepository.getAllUser();
      emit(UserSuccess(users: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }

  void getUser(int id) async {
    try {
      emit(UserLoading());
      final result = await userRepository.getUser(id);
      emit(UserCreated(user: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }

  void updateUser(int id, UserModel user) async {
    try {
      emit(UserLoading());
      final result = await userRepository.updateUser(id, user);

      emit(UserUpdated(user: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }

  void deleteUser(int id) async {
    try {
      emit(UserLoading());
      final result = await userRepository.deleteUser(id);
      emit(UserDeleted(message: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }
}
