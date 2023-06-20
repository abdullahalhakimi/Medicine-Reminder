import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/theme.dart';

class DateCard extends StatelessWidget {
  final DateTime? _selectedDay;
  const DateCard(this._selectedDay, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_selectedDay!.day< 10? '0': ''}${_selectedDay!.day} ${DateFormat('MMM').format(_selectedDay!)}.',
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.w500
          ),
        ),
        Text(
          DateFormat('EEEE').format(_selectedDay!).toUpperCase(),
          style: const TextStyle(
              fontSize: 18,
              letterSpacing: 2,
              color: MyColors.lightBlue,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}