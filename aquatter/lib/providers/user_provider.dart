import 'dart:convert';
import 'package:aquatter/components/my_profile.dart';
import 'package:aquatter/widgets/top_followed.dart';
import 'package:aquatter/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String username = '';
  String userId = '';
  List<dynamic> posts = [];
  List<Widget> myPosts = [];
  List<dynamic> follow = [];
  String avatar = '';
  List<UserCard> userCards = [];

  ///Adds a follower
  Future<int> addFollow(String userid) async {
    var response = await http.post(
        Uri.parse(
            'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/followers'),
        body: {
          'username': username,
        });
    return response.statusCode;
  }

  ///Removes a follower
  Future<int> removeFollow(String userid) async {
    var response = await http.get(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/followers?username=$username'),
    );
    List<dynamic> followers = json.decode(response.body);
    String followerid = followers[0]['id'];
    await http.delete(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/followers/$followerid'),
    );
    return response.statusCode;
  }

  ///Loads all the user cards filtered by username
  void searchForUsers(String username) async {
    userCards.clear();
    notifyListeners();
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username&sortBy=username&order=asc'));
    if (usersResponse.statusCode == 200) {
      List<dynamic> users = json.decode(usersResponse.body);
      for (var user in users) {
        if (user['username'] != this.username) {
          List<dynamic> posts = user['posts'];
          List<dynamic> followers = user['followers'];
          bool followed = false;
          for (var follower in followers) {
            if (follower['username'] == this.username) {
              followed = true;
            }
          }
          userCards.add(UserCard(
              userId: user['id'],
              followed: followed,
              image: user['avatar'],
              username: user['username'],
              posts: posts.length,
              followers: followers.length));
          notifyListeners();
        }
      }
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
    }
  }

  ///Returns the card of the most followed user
  Future<Widget> getMostFollowed() async {
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users'));
    if (usersResponse.statusCode == 200) {
      List<dynamic> users = json.decode(usersResponse.body);
      users.sort(
        (a, b) {
          List<dynamic> followersA = a['followers'];
          List<dynamic> followersB = b['followers'];
          return followersB.length.compareTo(followersA.length);
        },
      );
      List<dynamic> posts = users[0]['posts'];
      List<dynamic> followers = users[0]['followers'];
      return TopFollowed(
          userId: users[0]['id'],
          image: users[0]['avatar'],
          username: users[0]['username'],
          followers: followers.length,
          posts: posts.length);
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
      return Container();
    }
  }

  ///Returns a user profile
  Future<Widget> getProfile(String username) async {
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users'));
    if (usersResponse.statusCode == 200) {
      List<dynamic> users = json.decode(usersResponse.body);
      for (var user in users) {
        if (user['username'] == username) {
          List<dynamic> posts = user['posts'];
          List<dynamic> followers = user['followers'];
          return MyProfile(
            avatar: user['avatar'],
            username: username,
            description: user['description'],
            followers: followers.length,
            posts: posts.length,
            following: await getFollowing(username),
            myposts: posts,
          );
        }
      }
      return Container();
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
      return Container();
    }
  }

  ///Returns the number of followers
  Future<int> getFollowing(String username) async {
    int following = 0;
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users'));
    if (usersResponse.statusCode == 200) {
      List<dynamic> users = json.decode(usersResponse.body);
      for (var user in users) {
        List<dynamic> followers = user['followers'];
        for (var follower in followers) {
          follower['username'] == username ? following++ : null;
        }
      }
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
      return 0;
    }
    return following;
  }

  ///Updates the data of a user card
  void modifyCard(String userId, int followers, int posts, String image,
      bool followed, String username) {
    for (var card in userCards) {
      if (card.userId == userId) {
        userCards[userCards.indexOf(card)] = UserCard(
            image: image,
            username: username,
            posts: posts,
            followers: followers,
            followed: followed,
            userId: userId);
      }
    }
    notifyListeners();
  }

  ///Returns the user id and updates the provider userId
  void getUserId(String username) async {
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        if (element['username'] == username) {
          userId = element['id'];
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  ///Saves the username in shared and updates the provider username
  Future<bool> setLoged(String username) async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    await prefs.setString('username', username);
    this.username = username;
    return true;
  }

  ///Returns the username from shared and updates the provider username
  Future<String> getUsername() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    username = prefs.getString('username') ?? '';
    return username;
  }

  ///Checks if the pin code is correct
  Future<bool> isTheRealPincode(String pinCode) async {
    bool result = false;
    String username = await getUsername();
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username'));
    if (usersResponse.statusCode == 200) {
      var usersList = convert.jsonDecode(usersResponse.body) as List<dynamic>;
      for (var element in usersList) {
        if (element['username'] == username) {
          if (element['pincode'] == pinCode) {
            return true;
          }
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${usersResponse.statusCode}.');
    }
    return result;
  }

  ///Checks if the username is already existing
  Future<bool> usernameExisting(String username) async {
    bool result = false;
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        if (element['username'] == username) {
          result = true;
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  //////Checks if the password is correct
  Future<bool> isTheRealPassword(String username, String password) async {
    bool result = false;
    final response = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users?username=$username'));
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      for (var element in jsonResponse) {
        if (element['username'] == username) {
          if (element['password'] == password) {
            result = true;
          }
        }
      }
    } else {
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
    return result;
  }

  ///Registers a new user
  Future<bool> registerUser(
      String username, String email, String password, String pincode) async {
    final data = {
      'email': email,
      'password': password,
      'pincode': pincode,
      'username': username,
    };
    final response = await http.post(
      Uri.parse('https://63722218025414c637071928.mockapi.io/Aquatter/users/'),
      body: data,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
