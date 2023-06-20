import 'package:flutter/material.dart';
import 'package:medicine_reminder/theme.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

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
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          child: const Text('SKIP'),
        ),
      ],
    );
  }
}
