
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class Routing {
  static final Map<String, WidgetBuilder> routes = {
    'FirstScreen': (BuildContext context) => const FirstScreen(),
    'PinScreen': (BuildContext context) => const PinScreen(),
    'LoginScreen': (BuildContext context) => const LoginScreen(),
    'RegisterScreen': (BuildContext context) => const RegisterScreen(),
    'MainScreen': (BuildContext context) => const MainScreen(),
    'SplashScreen': (BuildContext context) => const SplashScreen(),
  };
}
