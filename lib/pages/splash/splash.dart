import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_reminder/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}
class SplashState extends State<Splash>  {

  // check if the user saw the tips or not
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushNamed('/landing1');

    }
  }

  @override
  void initState() {
    super.initState();
    // Timer for the Splash Screen
    Timer(
      const Duration(seconds: 2),
          () => checkFirstSeen(),
    );

  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double deviceWidth =
        MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/ic_launcher.png'),
            SizedBox(height:deviceHeight *0.1,),
            RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    style: TextStyle(
                      color: MyColors.green,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                      letterSpacing: 0.9,
                    ),
                    children: [
                      TextSpan(text: " Medicine",),
                      TextSpan(text: " Reminder",style: TextStyle(color: MyColors.darkGreen)),
                    ]
                )
            ),

            /*const Text(' Pill Reminder',
              style: TextStyle(
                  color: MyColors.darkBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  letterSpacing: 0.9,
              ),
            ),*/
            SizedBox(height:deviceHeight *0.1,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Loading... ',
                  style: TextStyle(
                    color: MyColors.darkGreen,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    letterSpacing: 0.9,
                  ),
                ),
                SizedBox(width:deviceWidth*0.01,),
                const SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    color: MyColors.green,

                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

