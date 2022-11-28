import 'dart:convert';
import 'package:aquatter/components/my_profile.dart';
import 'package:aquatter/widgets/top_followed.dart';
import 'package:aquatter/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  String username = '';
  List<dynamic> posts = [];
  List<Widget> myPosts = [];
  List<dynamic> follow = [];
  String avatar = '';
  List<UserCard> userCards = [];

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

  Future<int> addFollow(String userid) async {
    var response = await http.post(
        Uri.parse(
            'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/followers'),
        body: {
          'username': username,
        });
    return response.statusCode;
  }

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
}
