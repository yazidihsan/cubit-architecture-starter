import 'package:crudmvvm/data/data_provider/user/user_data_provider.dart';
import 'package:crudmvvm/models/user_model.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository(this.userDataProvider);

  Future<UserModel> createUser(UserModel user) async {
    try {
      final rawData = await userDataProvider.createUser(user.toJson());

      return UserModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      final rawData = await userDataProvider.getAllUser();

      return rawData.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<UserModel> getUser(int id) async {
    try {
      final rawData = await userDataProvider.getUser(id);

      return UserModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<UserModel> updateUser(int id, UserModel user) async {
    try {
      final rawData = await userDataProvider.updateUser(id, user.toJson());

      return UserModel.fromJson(rawData);
    } catch (e) {
      return throw Exception(e);
    }
  }

  Future<String> deleteUser(int id) async {
    try {
      final rawData = await userDataProvider.deleteUser(id);

      return rawData;
    } catch (e) {
      return throw Exception(e);
    }
  }
}
