import 'dart:convert';
import 'dart:developer';
import 'package:crudmvvm/theme_manager/value_manager.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client client;

  UserDataProvider(this.client);

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> postData) async {
    try {
      final response = await client.post(
          Uri.parse('${ValueManager.baseUrl}users'),
          body: jsonEncode(postData),
          headers: {
            'Content-Type': 'application/json',
          });
      log(response.body.toString());

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create data');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<List<dynamic>> getAllUser() async {
    try {
      final response =
          await client.get(Uri.parse('${ValueManager.baseUrl}users'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> getUser(int id) async {
    try {
      final response =
          await client.get(Uri.parse('${ValueManager.baseUrl}users/$id'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> updateUser(
      int id, Map<String, dynamic> postData) async {
    try {
      final response = await client.put(
          Uri.parse('${ValueManager.baseUrl}users/$id'),
          body: jsonEncode(postData),
          headers: {'Content-Type': 'application/json'});
      log(response.body.toString());
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update data');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }

  Future<String> deleteUser(int id) async {
    try {
      final response =
          await client.delete(Uri.parse('${ValueManager.baseUrl}users/$id'));

      if (response.statusCode == 200) {
        return jsonEncode(response.body);
      } else {
        throw Exception('Failed to delete data');
      }
    } catch (error) {
      return throw Exception(error);
    }
  }
}
