import 'package:aquatter/screens/screens.dart';
import 'package:flutter/cupertino.dart';

class Routing {
  static final Map<String, WidgetBuilder> routes = {
    'FirstScreen': (BuildContext context) => const FirstScreen(),
    'PinScreen': (BuildContext context) => const PinScreen(),
  };
}
