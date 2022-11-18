import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PostCardBottom extends StatefulWidget {
  const PostCardBottom(
      {super.key,
      required this.likes,
      required this.liked,
      required this.user,
      required this.title,
      required this.comments, required this.userId});

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
                      color: widget.liked ? Colors.yellow : Colors.white,
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Text(
                      widget.likes.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: defaultPadding * 3,
                      ),
                    ),
                    const SizedBox(
                      width: defaultPadding * 2,
                    ),
                    const Icon(
                      Icons.forum,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Text(
                      widget.comments.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: defaultPadding * 3,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 3,
                            vertical: defaultPadding * 10),
                        child: Card(
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: primaryColor.withOpacity(0.4),
                                width: defaultPadding / 4,
                              )),
                          margin: const EdgeInsets.symmetric(
                              vertical: defaultPadding,
                              horizontal: defaultPadding),
                          elevation: defaultPadding,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              clipBehavior: Clip.antiAlias,
                              children: _generateComments(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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

  List<Widget> _generateComments() {
    List<Comment> comments = [];
    for (var comment in widget.comments) {
      comments.add(Comment(user: comment['user'], userId: widget.userId, comment: comment['comment'], liked: false,likes: comment['likes'],commentId: comment['id'],postId: comment['postId'],));
    }
    return comments;
  }
}
