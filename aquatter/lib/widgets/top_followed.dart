import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class TopFollowed extends StatelessWidget {
  const TopFollowed(
      {super.key,
      required this.image,
      required this.username,
      required this.posts,
      required this.userId,
      required this.followers});

  final String image;
  final String username;
  final int posts;
  final int followers;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: defaultPadding,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 1,
                  child: Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: defaultPadding * 2,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        'Posts',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: defaultPadding * 1.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        posts.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: defaultPadding * 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Followers',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: defaultPadding * 1.5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        followers.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: defaultPadding * 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 10),
              child: Card(
                  color: primaryBlack,
                  elevation: defaultPadding,
                  child: FutureBuilder(
                    future:
                        Provider.of<UserProvider>(context).getProfile(username),
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data ?? Container();
                      } else {
                        return Container();
                      }
                    },
                  )),
            );
          },
        );
      },
    );
  }
}
