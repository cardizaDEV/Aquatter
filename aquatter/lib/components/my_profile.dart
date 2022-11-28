import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/my_post.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile(
      {super.key,
      required this.avatar,
      required this.username,
      required this.followers,
      required this.posts,
      required this.following,
      required this.myposts, required this.description});

  final String avatar;
  final int followers;
  final int following;
  final int posts;
  final String username;
  final String description;
  final List<dynamic> myposts;

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int lines = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: defaultPadding,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avatar),
                  minRadius: defaultPadding * 6,
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Posts',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 1.5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.posts.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Followers',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 1.5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.followers.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Following',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 1.5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            widget.following.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: defaultPadding * 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: defaultPadding * 2.5,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  widget.description,
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
              ),
              onTap: () {
                lines == 20 ? lines = 1 : lines = 20;
                setState(() {});
              },
            ),
            widget.myposts.isNotEmpty
                ? Flexible(
                    flex: 6,
                    fit: FlexFit.loose,
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        clipBehavior: Clip.antiAlias,
                        children: getMyPosts()))
                : const Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text(
                        'You have not posted yet',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: defaultPadding * 3,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )),
          ]),
    );
  }  List<Widget> getMyPosts() {
    List<Widget> posts = [];
    for (var post in widget.myposts) {
      posts.add(MyPost(post: post));
    }
    return posts;
  }
}
