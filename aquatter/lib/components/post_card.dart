import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/components/post_card_bottom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  const PostCard(
      {super.key,
      required this.user,
      required this.image,
      required this.likes,
      required this.title,
      required this.comments,
      required this.userId,
      required this.id, required this.liked});

  final String user;
  final String userId;
  final String id;
  final String title;
  final String image;
  final bool liked;
  final List<dynamic> likes;
  final List<dynamic> comments;

  @override
  // ignore: no_logic_in_create_state, unnecessary_this
  State<PostCard> createState() => _PostCardState(likes.length, this.liked);
}

class _PostCardState extends State<PostCard> {
  int _likes;
  bool _liked;
  _PostCardState(this._likes, this._liked);

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<UserProvider>(context, listen: false).username;

    return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 10),
            child: InkWell(
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: defaultPadding),
                elevation: defaultPadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(widget.image)),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PostCardBottom(
                          userId: widget.userId,
                          comments: widget.comments,
                          title: widget.title,
                          user: widget.user,
                          likes: _likes,
                          liked: _liked,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onDoubleTap: () {
                if (_liked) {
                  _liked = false;
                  _likes--;
                  Provider.of<PostsProvider>(context, listen: false)
                      .removeLike(widget.userId, widget.id, username);
                } else {
                  _liked = true;
                  _likes++;
                  Provider.of<PostsProvider>(context, listen: false)
                      .addLike(widget.userId, widget.id, username);
                }
                setState(() {});
              },
            ));
  }
}
