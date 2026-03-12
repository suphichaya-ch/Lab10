import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/users'; // [cite: 253]

  Future<List<UserModel>> fetchUsers() async {
    final res = await http.get(Uri.parse(_baseUrl)); // [cite: 255]
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body); // [cite: 257]
      return data.map((e) => UserModel.fromJson(e)).toList(); // [cite: 258]
    }
    throw Exception('Failed to load users (${res.statusCode})'); // [cite: 259]
  }

  Future<UserModel> createUser(UserModel user) async {
    final res = await http.post(
      Uri.parse(_baseUrl), // [cite: 271]
      headers: {'Content-Type': 'application/json'}, // [cite: 272]
      body: jsonEncode(user.toJson()), // [cite: 273]
    );
    if (res.statusCode == 200 || res.statusCode == 201) { // [cite: 275]
      return UserModel.fromJson(jsonDecode(res.body)); // [cite: 276]
    }
    throw Exception('Failed to create user (${res.statusCode})'); // [cite: 279]
  }

  Future<UserModel> updateUser(int id, UserModel user) async {
    final res = await http.put(
      Uri.parse('$_baseUrl/$id'), // [cite: 283]
      headers: {'Content-Type': 'application/json'}, // [cite: 284]
      body: jsonEncode(user.toJson()), // [cite: 286]
    );
    if (res.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(res.body)); // [cite: 288]
    }
    throw Exception('Failed to update user ($id) (${res.statusCode})'); // [cite: 291]
  }

  Future<void> deleteUser(int id) async {
    final res = await http.delete(Uri.parse('$_baseUrl/$id')); // [cite: 293]
    if (res.statusCode == 200) return; // [cite: 294]
    throw Exception('Failed to delete user ($id) (${res.statusCode})'); // [cite: 295]
  }
}