import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({@required this.icon, @required this.label, this.textStyle});
  final IconData icon;
  final String label;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: kIconSize,
        ),
        SizedBox(
          height: kVerticalGapSize,
        ),
        Text(
          label,
          style: textStyle != null ? textStyle : kLabelTextStyle,
        ),
      ],
    );
  }
}
