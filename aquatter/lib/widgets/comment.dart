import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:http/http.dart' as http;

import '../themes/constants.dart';

class Comment extends StatefulWidget {
  const Comment(
      {super.key,
      required this.user,
      required this.comment,
      required this.liked,
      required this.likes,
      required this.userId,
      required this.postId,
      required this.commentId});

  final String user;
  final String comment;
  final String userId;
  final String postId;
  final String commentId;
  final bool liked;
  final int likes;

  @override
  // ignore: no_logic_in_create_state
  State<Comment> createState() => _CommentState(likes, liked);
}

class _CommentState extends State<Comment> {
  int _likes;
  bool _liked;
  _CommentState(this._likes, this._liked);

  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: primaryColor.withOpacity(0.4),
            width: defaultPadding / 4,
          )),
      margin: const EdgeInsets.symmetric(
          vertical: defaultPadding, horizontal: defaultPadding),
      elevation: defaultPadding,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: defaultPadding * 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              widget.comment,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                color: Colors.black,
                fontSize: defaultPadding * 1.5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(
              child: Column(
                children: [
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: defaultPadding * 3,
                            color: _liked ? Colors.yellow : Colors.grey,
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text(
                            _likes.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: defaultPadding * 1.5,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _likes >= 75 ? parser.emojify('🐡') : '',
                        style: const TextStyle(
                          fontSize: defaultPadding * 3,
                        ),
                      )
                    ],
                  )
                ],
              ),
              onTap: () {
                if (_liked) {
                  _liked = false;
                  _likes--;
                } else {
                  _liked = true;
                  _likes++;
                }
                _updateLikes();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  void _updateLikes() async {
    var userid = widget.userId;
    var postid = widget.postId;
    var commentid = widget.commentId;
    await http.put(
      Uri.parse(
          'https://63722218025414c637071928.mockapi.io/Aquatter/user/$userid/post/$postid/comments/$commentid'),
      body: {'likes': _likes.toString()},
    );
  }
}
