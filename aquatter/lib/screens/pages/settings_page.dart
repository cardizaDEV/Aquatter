import 'package:aquatter/themes/constants.dart';
import 'package:aquatter/widgets/color_config.dart';
import 'package:aquatter/widgets/profile_config.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Center(
          child: Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  'Profile Settings',
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
        ),
        ProfileConfig(),
        Center(
          child: Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  'Color Settings',
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
        ),
        Center(
          child: Flexible(
              flex: 1,
              child: Text(
                  'Not working',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Color.fromARGB(255, 189, 91, 91),
                    fontSize: defaultPadding * 2,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
        ),
        ColorConfig(),
      ],
    );
  }
}
