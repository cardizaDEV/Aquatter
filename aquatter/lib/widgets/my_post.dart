import 'package:aquatter/components/post_card.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  const MyPost({super.key, required this.post});

  final Map<String, dynamic> post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              Image(fit: BoxFit.fitHeight, image: NetworkImage(post['image'])),
            ],
          ),
        ),
      ),
      onTap: () {
        showDialog(context: context, builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 10),
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
                          image: NetworkImage(post['image'])),
                    ]
                  )
                )
            ),
          );
        });
      },
    );
  }
}
