import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentsProvider extends ChangeNotifier {
  Future<List<dynamic>> getCommentLikes(
      String userid, String postid, String commentId) async {
    var response = await http.get(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/comments/$commentId/likes'),
    );
    List<dynamic> likes = json.decode(response.body);
    return likes;
  }
  void addLike(String userid, String postid, String username, String commentId) async {
    await http.post(
        Uri.parse(
            'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/comments/$commentId/likes'),
        body: {
          'username': username,
        });
  }
  void removeLike(String userid, String postid, String username, String commentId) async {
    var response = await http.get(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/comments/$commentId/likes?username=$username'),
    );
    List<dynamic> likes = json.decode(response.body);
    String likeid = likes[0]['id'];
    await http.delete(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/users/$userid/posts/$postid/comments/$commentId/likes/$likeid'),
    );
  }
}
