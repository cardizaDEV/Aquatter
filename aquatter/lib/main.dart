import 'package:aquatter/router/routing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aquatter',
        routes: Routing.routes,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _isFirstLogin(),
          builder: ((BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                Future.delayed(Duration.zero,(){
                  Navigator.pushNamed(context, 'FirstScreen');
                });
                return Container();
              } else {
                Future.delayed(Duration.zero,(){
                  Navigator.pushNamed(context, 'PinScreen');
                });
                return Container();
              }
            } else {
              return Container();
            }
          }),
        ));
  }

  Future<bool> _isFirstLogin() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    if (prefs.getString("email") != null) {
      return false;
    } else {
      return true;
    }
  }
}
