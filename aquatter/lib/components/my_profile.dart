import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/my_post.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile(
      {super.key,
      required this.avatar,
      required this.username,
      required this.followers,
      required this.posts,
      required this.following,
      required this.myposts});

  final String avatar;
  final int followers;
  final int following;
  final int posts;
  final String username;
  final List<dynamic> myposts;

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
                  backgroundImage: NetworkImage(avatar),
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
                            posts.toString(),
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
                            followers.toString(),
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
                            following.toString(),
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
                    username,
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
            const SizedBox(
              height: defaultPadding * 2,
            ),
            myposts.isNotEmpty
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
                    )),
          ]),
    );
  }

  List<Widget> getMyPosts() {
    List<Widget> posts = [];
    for (var post in myposts) {
      posts.add(MyPost(post: post));
    }
    return posts;
  }
}
