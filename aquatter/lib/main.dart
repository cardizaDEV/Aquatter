import 'package:aquatter/providers/comments_provider.dart';
import 'package:aquatter/providers/image_picker_provider.dart';
import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/providers/user_provider.dart';
import 'package:aquatter/router/routing.dart';
import 'package:aquatter/screens/screens.dart';
import 'package:aquatter/themes/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
          ChangeNotifierProvider<PostsProvider>(create: (_) => PostsProvider()),
          ChangeNotifierProvider<ImagePickerProvider>(create: (_) => ImagePickerProvider()),
          ChangeNotifierProvider<CommentsProvider>(create: (_) => CommentsProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Aquatter',
            routes: Routing.routes,
            theme: MainTheme.mainTheme,
            home: FutureBuilder(
              future: _isFirstLogin(),
              builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacementNamed(context, 'FirstScreen');
                    });
                    return const SplashScreen();
                  } else {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacementNamed(context, 'PinScreen');
                    });
                    return const SplashScreen();
                  }
                } else {
                  return const SplashScreen();
                }
              }),
            )));
  }

  Future<bool> _isFirstLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    if (prefs.getString("username") != null) {
      return false;
    } else {
      return true;
    }
  }
}
