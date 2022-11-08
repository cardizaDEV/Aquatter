import 'package:aquatter/screens/login_register/login_screen.dart';
import 'package:aquatter/screens/login_register/register_screen.dart';
import 'package:aquatter/screens/screens.dart';
import 'package:aquatter/screens/social_screen.dart';
import 'package:flutter/cupertino.dart';

class Routing {
  static final Map<String, WidgetBuilder> routes = {
    'FirstScreen': (BuildContext context) => const FirstScreen(),
    'PinScreen': (BuildContext context) => const PinScreen(),
    'LoginScreen': (BuildContext context) => const LoginScreen(),
    'RegisterScreen': (BuildContext context) => const RegisterScreen(),
    'SocialScreen': (BuildContext context) => const SocialScreen(),
  };
}
