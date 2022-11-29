import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorConfig extends StatefulWidget {
  const ColorConfig({super.key});

  @override
  State<ColorConfig> createState() => _ColorConfigState();
}

class _ColorConfigState extends State<ColorConfig> {
  static const Color primaryColor = Color.fromRGBO(113, 167, 207, 1);
  static const Color primaryBlack = Color.fromRGBO(13, 30, 55, 1);

  Color pickedPrimary = primaryColor;
  Color currentPrimary = primaryColor;

  Color pickedBlack = primaryBlack;
  Color currentBlack = primaryBlack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(defaultPadding),
            color: Colors.white.withOpacity(0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/(defaultPadding*2.5),
                      width: MediaQuery.of(context).size.width/defaultPadding*4,
                      color: currentBlack,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: pickedBlack,
                                      onColorChanged: changeBlack,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(() => currentBlack = pickedBlack);
                                        setPrimaryBlack();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }));
                        },
                        child: const Text('Primary Color')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/(defaultPadding*2.5),
                      width: MediaQuery.of(context).size.width/defaultPadding*4,
                      color: currentPrimary,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: pickedPrimary,
                                      onColorChanged: changePrimary,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(
                                            () => currentPrimary = pickedPrimary);
                                        setPrimaryColor();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }));
                        },
                        child: const Text('Secondary Color')),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () => restoreDefaults(),
                  child: const Text('Restore defaults')),
            ],
          )
        ],
      ),
    );
  }

  void changePrimary(Color color) {
    setState(() => pickedPrimary = color);
  }

  void changeBlack(Color color) {
    setState(() => pickedBlack = color);
  }

  void restoreDefaults() {
    pickedPrimary = primaryColor;
    currentPrimary = primaryColor;
    pickedBlack = primaryBlack;
    currentBlack = primaryBlack;
    setState(() {});
    setPrimaryBlack();
    setPrimaryColor();
  }

  ///Saves the username in shared and updates the provider username
  void setPrimaryColor() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    await prefs.setString('primaryColor', currentPrimary.toString());
  }

  ///Saves the username in shared and updates the provider username
  void setPrimaryBlack() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences prefs = await _prefs;
    await prefs.setString('blackColor', currentBlack.toString());
  }
}
