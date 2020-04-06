import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender {
  male,
  female,
  notSelected,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.notSelected;
  TextStyle selectedTextStyle;
  int height = kInitialHeight;
  Color selectedSliderColor = Colors.grey;
  int weight = kInitialWeight;
  int age = kInitialAge;

  void incrementWeight() {
    setState(() {
      if (weight <= 199) {
        weight++;
      } else {}
    });
  }

  void decreaseWeight() {
    setState(() {
      if (weight >= 31) {
        weight--;
      } else {}
    });
  }

  void incrementAge() {
    setState(() {
      if (age <= 149) {
        age++;
      } else {}
    });
  }

  void decreaseAge() {
    setState(() {
      if (age >= 11) {
        age--;
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.fitness_center),
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                        selectedTextStyle = kMaleTextStyle;
                        selectedSliderColor = kMaleSliderColor;
                      });
                    },
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: 'MALE',
                      textStyle: selectedTextStyle == kMaleTextStyle
                          ? kMaleTextStyle
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.female;
                        selectedTextStyle = kFemaleTextStyle;
                        selectedSliderColor = kFemaleSliderColor;
                      });
                    },
                    color: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: 'FEMALE',
                      textStyle: selectedTextStyle == kFemaleTextStyle
                          ? kFemaleTextStyle
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              color: kActiveCardColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: selectedTextStyle != null
                        ? selectedTextStyle
                        : kLabelTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kNumberStyle,
                      ),
                      Text(
                        ' CM',
                        style: kLabelTextStyle,
                      )
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 12),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30)),
                    child: Slider(
                      value: height.toDouble(),
                      min: kSliderMin,
                      max: kSliderMax,
                      divisions: kDivisions,
                      activeColor: selectedSliderColor,
                      inactiveColor: kInactiveSliderColor,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: selectedTextStyle != null
                              ? selectedTextStyle
                              : kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.arrow_downward),
                              textColor: Colors.white,
                              onPressed: () => decreaseWeight(),
                              elevation: 8,
                            ),
                            RaisedButton(
                              child: Icon(Icons.arrow_upward),
                              textColor: Colors.white,
                              onPressed: () => incrementWeight(),
                              elevation: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: selectedTextStyle != null
                              ? selectedTextStyle
                              : kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kNumberStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.arrow_downward),
                              textColor: Colors.white,
                              onPressed: () => decreaseAge(),
                              elevation: 8,
                            ),
                            RaisedButton(
                              child: Icon(Icons.arrow_upward),
                              textColor: Colors.white,
                              onPressed: () => incrementAge(),
                              elevation: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            bottomColor: selectedSliderColor,
            buttonTitle: 'CALCULATE',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                    selectedColor: selectedSliderColor,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
