import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String username = '';
  List<dynamic> posts = [];
  List<dynamic> follow = [];
  String avatar = '';

  void setUsername(String username) {
    this.username = username;
    notifyListeners();
  }

  void addPost(dynamic post) {
    posts.add(post);
    notifyListeners();
  }

  void removePost(dynamic post) {
    posts.remove(post);
    notifyListeners();
  }

  void addFollow(String username) {
    follow.add(username);
    notifyListeners();
  }

  void removeFollow(String username) {
    follow.remove(username);
    notifyListeners();
  }
}
