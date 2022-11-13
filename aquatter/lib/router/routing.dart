import 'package:aquatter/screens/screens.dart';
import 'package:flutter/material.dart';

class Routing {
  static final Map<String, WidgetBuilder> routes = {
    'FirstScreen': (BuildContext context) => const FirstScreen(),
    'PinScreen': (BuildContext context) => const PinScreen(),
    'LoginScreen': (BuildContext context) => const LoginScreen(),
    'RegisterScreen': (BuildContext context) => const RegisterScreen(),
    'SocialScreen': (BuildContext context) => const SocialScreen(),
    'SplashScreen': (BuildContext context) => const SplashScreen(),
  };
}
