import 'package:aquatter/providers/comments_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/comment.dart';
import 'package:aquatter/widgets/your_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:provider/provider.dart';

class PostCardBottom extends StatefulWidget {
  const PostCardBottom(
      {super.key,
      required this.likes,
      required this.liked,
      required this.user,
      required this.title,
      required this.comments,
      required this.userId});

  final int likes;
  final List<dynamic> comments;
  final bool liked;
  final String user;
  final String userId;
  final String title;

  @override
  State<PostCardBottom> createState() => _PostCardBottomState();
}

class _PostCardBottomState extends State<PostCardBottom> {
  int lines = 3;

  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 3,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      shadows: <Shadow>[
                        Shadow(
                          //offset: Offset(0.0, 0.0),
                          blurRadius: defaultPadding * 4,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                InkWell(
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: lines,
                    style: const TextStyle(
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                        shadows: <Shadow>[
                          Shadow(
                            //offset: Offset(0.0, 0.0),
                            blurRadius: defaultPadding * 4,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),
                  ),
                  onTap: () {
                    lines == 20 ? lines = 3 : lines = 20;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        shadows: const <Shadow>[
                          Shadow(
                            //offset: Offset(0.0, 0.0),
                            blurRadius: defaultPadding * 4,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                        color: widget.liked ? Colors.yellow : Colors.white,
                      ),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        widget.likes.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              //offset: Offset(0.0, 0.0),
                              blurRadius: defaultPadding * 4,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          fontSize: defaultPadding * 3,
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding * 2,
                      ),
                      const Icon(
                        Icons.forum,
                        shadows: <Shadow>[
                          Shadow(
                            //offset: Offset(0.0, 0.0),
                            blurRadius: defaultPadding * 4,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      Text(
                        widget.comments.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              //offset: Offset(0.0, 0.0),
                              blurRadius: defaultPadding * 4,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          fontSize: defaultPadding * 3,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String username =
                            Provider.of<UserProvider>(context, listen: false)
                                .username;
                        return FutureBuilder(
                            future: _generateComments(username),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Widget>> snapshot) {
                              if (snapshot.hasData) {
                                return Scaffold(
                                  resizeToAvoidBottomInset: true,
                                  body: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: defaultPadding * 2,
                                            vertical: defaultPadding * 10),
                                        child: Card(
                                          semanticContainer: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              side: BorderSide(
                                                color:
                                                    primaryColor.withOpacity(0.4),
                                                width: defaultPadding / 4,
                                              )),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: defaultPadding,
                                              horizontal: defaultPadding),
                                          elevation: defaultPadding,
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                defaultPadding),
                                            child: ListView(
                                              scrollDirection: Axis.vertical,
                                              clipBehavior: Clip.antiAlias,
                                              shrinkWrap: true,
                                              children: snapshot.data ?? [],
                                            ),
                                          ),
                                        )),
                                  ),
                                );
                              } else {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 3,
                                        vertical: defaultPadding * 10),
                                    child: Card(
                                        semanticContainer: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: BorderSide(
                                              color:
                                                  primaryColor.withOpacity(0.4),
                                              width: defaultPadding / 4,
                                            )),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: defaultPadding,
                                            horizontal: defaultPadding),
                                        elevation: defaultPadding,
                                        child: Container()));
                              }
                            });
                      },
                    );
                  }),
              const SizedBox(
                width: defaultPadding,
              ),
              Text(
                parser.emojify('🐡'),
                style: const TextStyle(
                  fontSize: defaultPadding * 4,
                ),
              )
            ],
          ),
          const SizedBox(
            height: defaultPadding * 2,
          )
        ],
      ),
    );
  }

  Future<List<Widget>> _generateComments(String username) async {
    List<Widget> comments = [];
    for (var comment in widget.comments) {
      bool liked = false;
      List<dynamic> likes =
          await Provider.of<CommentsProvider>(context, listen: false)
              .getCommentLikes(widget.userId, comment['postId'], comment['id']);
      for (var like in likes) {
        if (like['username'] == username) {
          liked = true;
        }
      }
      comments.add(Comment(
        user: comment['username'],
        userId: widget.userId,
        comment: comment['comment'],
        liked: liked,
        likes: likes.length,
        commentId: comment['id'],
        postId: comment['postId'],
      ));
    }
    comments.add(YourComment(username: username,postid: widget.comments[0]['postId'],userid: widget.userId,));
    comments.add(Expanded(child: Container()));
    return comments;
  }
}
