import 'package:flutter/material.dart';
import 'package:medicine_reminder/extensions/context_extension.dart';
import 'package:medicine_reminder/pages/landing/components/customImage.dart';
import 'package:medicine_reminder/pages/landing/components/nextButton.dart';
import 'package:medicine_reminder/pages/landing/components/textSection.dart';
import 'package:medicine_reminder/theme.dart';

class Landing3 extends StatelessWidget {
  const Landing3({super.key});

  @override
  Widget build(BuildContext context) {

    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    Widget body = Column(
        children:[
          //skipButton,
          Expanded(
            child:
            Center(
              child: ListView(
                  shrinkWrap: true,
                  children: [
                    const CustomImage(imagePath: 'assets/landing3.png'),
                    SizedBox(height: deviceHeight * 0.05,),
                    TextSection(
                        'Medicine Cabinet',
                        context.localizations!.landing3Description,
                    ),
                  ]
              ),
            ),
          ),
          const NextButton('/home'),
        ]);


    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if(details.primaryDelta! > 0) {
          Navigator.pop(context);
        }
        else if(details.primaryDelta! < 0) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      },
      child: Scaffold(
            backgroundColor: MyColors.landing3,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10,50,10,25),
              child: body,
            )
        ),
    );
  }
}

