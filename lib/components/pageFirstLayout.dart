import 'package:flutter/material.dart';
import 'package:medicine_reminder/components/curvedContainer.dart';
import 'package:medicine_reminder/theme.dart';


class PageFirstLayout extends StatelessWidget {
  const PageFirstLayout(
      {super.key,
        this.appBarTitle ='',
        this.appBarRight = const SizedBox(height: 0, width: 0),
        this.color = MyColors.landing2,
        this.topChild =  const SizedBox(height: 0, width: 0) ,
        this.containerChild = const SizedBox(height: 0, width: 0) ,
      });

  final Widget topChild;
  final Widget containerChild;
  final Widget appBarRight;
  final String appBarTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        toolbarHeight: 80,
        titleSpacing: 30,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: MyColors.lightWhite,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6
          ),
        ),
        actions: [
          appBarRight
        ],
        elevation: 0.0,
        backgroundColor: color,
        iconTheme: const IconThemeData(
          color: MyColors.lightWhite, //change your color here
        ),
      ),
      body:
      Column(
        children: [
        topChild,
        CurvedContainer(
            containerChild
        ),
        ],
      ),
    );
  }
}
