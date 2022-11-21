import 'dart:convert';

import 'package:aquatter/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PostsProvider extends ChangeNotifier {
  List<PostCard> posts = [];

  void addPost(dynamic post) {
    posts.add(post);
    notifyListeners();
  }

  void removePost(dynamic post) {
    posts.remove(post);
    notifyListeners();
  }

  void reloadPosts(String username) async {
    posts.clear();
    notifyListeners();
    final usersResponse = await http.get(Uri.parse(
        'https://63722218025414c637071928.mockapi.io/Aquatter/users'));
    if (usersResponse.statusCode == 200) {
      List<Map<String, Map<String, dynamic>>> postList = [];
      List<dynamic> users = convert.jsonDecode(usersResponse.body);
      for (var user in users) {
        for (var post in user['posts']) {
          postList.add({user['username']: post});
        }
      }
      postList.sort(
        (a, b) {
          var postDateA = a.values.map((post) => post['postdate']);
          var postDateB = b.values.map((post) => post['postdate']);
          return postDateA.toString().compareTo(postDateB.toString());
        },
      );
      if (postList.isNotEmpty) {
        for (var post in postList) {
          var userId =
              post.values.map((e) => e['userId'].toString()).elementAt(0);
          var id = post.values.map((e) => e['id'].toString()).elementAt(0);
          final postResponse = await http.get(Uri.parse(
              // ignore: prefer_interpolation_to_compose_strings
              'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userId/posts/$id'));
          if (postResponse.statusCode == 200) {
            Map<String, dynamic> postMap =
                convert.jsonDecode(postResponse.body);
            bool liked = false;
            for (var like in postMap['likes']) {
              if (like['username'] == username) {
                liked = true;
              }
            }
            posts.add(PostCard(
                id: id,
                userId: userId,
                user: post.keys.elementAt(0),
                image: postMap['image'],
                likes: postMap['likes'],
                title: postMap['title'],
                liked: liked,
                comments: postMap['comments']));
            notifyListeners();
          } else if (postResponse.statusCode == 429) {
            await Future.delayed(const Duration(seconds: 1));
          } else {
            // ignore: avoid_print
            print(
                'Post Request failed with status: ${postResponse.statusCode}.');
          }
        }
      }
    } else if (usersResponse.statusCode == 429) {
      await Future.delayed(const Duration(seconds: 1));
    } else {
      // ignore: avoid_print
      print('User Request failed with status: ${usersResponse.statusCode}.');
    }
  }

  void addLike(String userid, String postid, String username) async {
    await http.post(
        Uri.parse(
            'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/likes'),
        body: {
          'username': username,
        });
  }

  void removeLike(String userid, String postid, String username) async {
    var response = await http.get(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/likes?username=$username'),
    );
    List<dynamic> likes = json.decode(response.body);
    String likeid = likes[0]['id'];
    await http.delete(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/likes/$likeid'),
    );
  }
}
