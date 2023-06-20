import 'package:flutter/material.dart';
import 'package:medicine_reminder/pages/landing/components/customImage.dart';
import 'package:medicine_reminder/pages/landing/components/nextButton.dart';
import 'package:medicine_reminder/pages/landing/components/skipButton.dart';
import 'package:medicine_reminder/pages/landing/components/textSection.dart';
import 'package:medicine_reminder/theme.dart';

class Landing2 extends StatelessWidget {
  const Landing2({super.key});

  @override
  Widget build(BuildContext context) {

    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Widget body = Column(
        children:[
          const SkipButton(),
          Expanded(
            child:
            Center(
              child: ListView(
                  shrinkWrap: true,
                  children: [
                    const TextSection(
                        'Medicine Reminders',
                        'For all of your medications with a logbook for skipped and confirmed intakes.'
                    ),
                    SizedBox(height: deviceHeight * 0.05,),
                    const CustomImage(imagePath: 'assets/landing2.png'),
                  ]
              ),
            ),
          ),
          const NextButton('/landing3'),
        ]);


    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if(details.primaryDelta! > 0) {
          Navigator.pop(context);
        }
        else if(details.primaryDelta! < 0) {
          Navigator.pushNamed(context, '/landing3');
        }
      },
      child: Scaffold(
            backgroundColor: MyColors.landing2,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10,50,10,25),
              child: body,
            )
        ),
    );
  }
}

