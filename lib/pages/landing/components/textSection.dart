import 'package:flutter/material.dart';
import 'package:medicine_reminder/theme.dart';

class TextSection extends StatelessWidget {

  final String title;
  final String paragraph;
  const TextSection(this.title, this.paragraph, {super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPadding = MediaQuery. of(context). size. width / 20;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: MyColors.lightWhite,
                    letterSpacing: 0.2,
                    wordSpacing: 0.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  paragraph,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 16,
                    wordSpacing: 0.5,
                    letterSpacing: 0.2,
                    color: MyColors.darkGray
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
