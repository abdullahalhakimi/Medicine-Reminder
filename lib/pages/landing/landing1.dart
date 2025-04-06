import 'package:flutter/material.dart';
import 'package:medicine_reminder/extensions/context_extension.dart';
import 'package:medicine_reminder/pages/landing/components/customImage.dart';
import 'package:medicine_reminder/pages/landing/components/nextButton.dart';
import 'package:medicine_reminder/pages/landing/components/skipButton.dart';
import 'package:medicine_reminder/pages/landing/components/textSection.dart';
import 'package:medicine_reminder/theme.dart';

class Landing1 extends StatelessWidget {
  const Landing1({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Widget body = Column(children: [
      const SkipButton(),
      Expanded(
        child: Center(
          child: ListView(shrinkWrap: true, children: [
            const CustomImage(imagePath: 'assets/landing1.png'),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            TextSection(
              context.localizations!.landing1Title,
              context.localizations!.landing1Description,
            ),
          ]),
        ),
      ),
      const NextButton('/landing2'),
    ]);

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! < 0) {
          Navigator.pushNamed(context, '/landing2');
        }
      },
      child: Scaffold(
          backgroundColor: MyColors.landing1,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 25),
            child: body,
          )),
    );
  }
}
