import 'package:flutter/material.dart';

import '../../../theme.dart';

class NextButton extends StatelessWidget {

  final String nextRoute;
  const NextButton(this.nextRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: MyColors.lightWhite,
            textStyle: const TextStyle(fontSize: 16, letterSpacing: 2,fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            if (nextRoute == '/home') {
              Navigator.pushNamedAndRemoveUntil(context, nextRoute, (route) => false);
            }else {
              Navigator.pushNamed(context, nextRoute);
            }
          },
          child: Text(nextRoute == '/home'? 'START': 'NEXT'),
        ),
      ],
    );
  }
}
