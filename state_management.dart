
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserViewModel(
        repository: UserRepository(
          remoteDataSource: UserRemoteDataResource(),
        ),~
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
//     final userViewModel = Provider.of<UserViewModel>(context);
    return MaterialApp(
      home: Consumer<UserViewModel>(
        builder: (context, provider, child) {
          return Text('${provider.users.length}');
        },
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], email: json['email']);
  }
}

class UserRemoteDataResource {
  final String apiUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("데이터를 불러올 수 없습니다");
    }
  }
}

class UserRepository {
  final UserRemoteDataResource remoteDataSource;

  UserRepository({required this.remoteDataSource});

  Future<List<User>> getUser() async {
    return await remoteDataSource.fetchUsers();
  }
}

class UserViewModel extends ChangeNotifier {
  final UserRepository repository;
  List<User> _users = [];
  bool _isLoading = false;

  UserViewModel({required this.repository}) {
    loadUser();
  }

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await repository.getUser();
    } catch (e) {
      print("error!");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
