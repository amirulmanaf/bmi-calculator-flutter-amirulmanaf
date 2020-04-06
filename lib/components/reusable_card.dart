import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.color, this.cardChild, this.onPress});

  final Color color;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[4],
          color: color,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        margin: EdgeInsets.all(kEdgeMargin),
      ),
    );
  }
}
