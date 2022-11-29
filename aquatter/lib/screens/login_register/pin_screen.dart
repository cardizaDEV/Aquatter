import 'package:aquatter/providers/posts_provider.dart';
import 'package:aquatter/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String pinText = '';
  TextEditingController pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("lib/media/hatching-ge35f10e1a_1280.png"),
            fit: BoxFit.cover,
            opacity: 1,
          )),
      child: Scaffold(
        backgroundColor: primaryBlack.withOpacity(0.9),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(defaultPadding * 2),
            color: Colors.white.withOpacity(1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  right: screenHeight / 12,
                  left: screenHeight / 12,
                  top: screenHeight / 16,
                  bottom: screenHeight / 16),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                PinCodeTextField(
                  controller: pinCodeController,
                  autoFocus: true,
                  obscureText: true,
                  autoUnfocus: true,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    inactiveColor: primaryColor,
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  appContext: context,
                  length: 4,
                  onCompleted: (value) async {
                    if (await Provider.of<UserProvider>(context, listen: false)
                            .isTheRealPincode(value) ==
                        true) {
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          // ignore: use_build_context_synchronously
                          .getUserData(
                              // ignore: use_build_context_synchronously
                              Provider.of<UserProvider>(context, listen: false)
                                  .username);
                      // ignore: use_build_context_synchronously
                      Provider.of<UserProvider>(context, listen: false)
                          .searchForUsers('');
                      // ignore: use_build_context_synchronously
                      Provider.of<PostsProvider>(context, listen: false)
                          .reloadPosts(
                              // ignore: use_build_context_synchronously
                              Provider.of<UserProvider>(context, listen: false)
                                  .username);
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'MainScreen');
                    } else {
                      pinCodeController.clear();
                    }
                  },
                  onChanged: (String value) {
                    setState(() {
                      pinText = value;
                    });
                  },
                ),
                const SizedBox(
                  height: defaultPadding * 3,
                ),
                ElevatedButton(
                  child: const Text('Back'),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'FirstScreen'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
