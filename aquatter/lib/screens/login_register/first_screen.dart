import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screen_height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            right: screen_height / 12,
            left: screen_height / 12,
            top: screen_height / 8,
            bottom: screen_height / 12),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          const Placeholder(),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: screen_height / 16),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: const [
              ElevatedButton(onPressed: null, child: Text('Login')),
              ElevatedButton(onPressed: null, child: Text('Register')),
            ],
          )
        ],
      ),
    );
  }
}
