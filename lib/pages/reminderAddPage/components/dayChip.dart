import 'package:flutter/material.dart';
import 'package:medicine_reminder/theme.dart';

class DayChip extends StatelessWidget {
  const DayChip({Key? key,
    this.label ='',
    this.selected = false,
    this.onSelected
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 20,
          ),
          child: Text('$label',style: TextStyle(color: MyColors.lightWhite),)),
      selected: selected,
      onSelected: onSelected,
      selectedColor: MyColors.lightBlue,
      backgroundColor: MyColors.lightGray,
      elevation: 4,
      showCheckmark: false,
    );
  }
}
