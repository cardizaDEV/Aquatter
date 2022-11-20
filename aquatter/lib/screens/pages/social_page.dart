import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:provider/provider.dart';

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    SwiperController swiperController = SwiperController();
    int actualCardIndex = 1;
    // ignore: prefer_typing_uninitialized_variables
    var initial;
    // ignore: prefer_typing_uninitialized_variables
    var distance;
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
              fit: BoxFit.cover,
              opacity: 0.2,
            )),
        child: Consumer<PostsProvider>(builder: (context, provider, child) {
          return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanStart: (DragStartDetails details) {
                initial = details.globalPosition.dx;
              },
              onPanUpdate: (DragUpdateDetails details) {
                distance = details.globalPosition.dx - initial;
              },
              onPanEnd: (DragEndDetails details) {
                if (distance < 0 ?? false) {
                  if (actualCardIndex < provider.posts.length - 2) {
                    swiperController.next();
                  }
                } else {
                  if (actualCardIndex >= 1) {
                    swiperController.previous();
                  } else {
                    Provider.of<PostsProvider>(context, listen: false)
                        .reloadPosts(Provider.of<UserProvider>(context, listen: false).username);
                  }
                }
              },
              child: Swiper(
                loop: false,
                fade: 0.8,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                autoplay: false,
                controller: swiperController,
                itemCount: provider.posts.length,
                itemBuilder: (context, index) {
                  actualCardIndex = index;
                  return provider.posts.elementAt(index);
                },
              ));
        }));
  }
}
