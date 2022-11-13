import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class PostCardBottom extends StatelessWidget {
  const PostCardBottom({super.key, required this.likes, required this.user, required this.liked});

  final int likes;
  final String user;
  final bool liked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: defaultPadding,
        ),
        InkWell(
            child: Row(
          children: [Text(user)],
        )),
        const SizedBox(
          width: defaultPadding,
        ),
        InkWell(
            child: Row(
          children: [
            Icon(liked ? Icons.favorite : Icons.favorite_outline),
            Text(likes.toString())
          ],
        ))
      ],
    );
  }
}
