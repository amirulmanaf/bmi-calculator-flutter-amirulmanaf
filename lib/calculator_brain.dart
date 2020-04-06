import 'dart:math';

enum BmiCat { underweight, healthy, overweight, obese, severelyObese }

class CalculatorBrain {
  CalculatorBrain({this.height, this.weight});

  final int height;
  final int weight;

  double _bmi;
  BmiCat _bmiCat;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    if (_bmi >= 40)
      _bmiCat = BmiCat.severelyObese;
    else if (_bmi >= 30)
      _bmiCat = BmiCat.obese;
    else if (_bmi >= 25)
      _bmiCat = BmiCat.overweight;
    else if (_bmi >= 18.5)
      _bmiCat = BmiCat.healthy;
    else
      _bmiCat = BmiCat.underweight;
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmiCat == BmiCat.severelyObese)
      return 'Severely Obese';
    else if (_bmiCat == BmiCat.obese)
      return 'Obese';
    else if (_bmiCat == BmiCat.overweight)
      return 'Overweight';
    else if (_bmiCat == BmiCat.healthy)
      return 'Healthy';
    else
      return 'Underweight';
  }

  String getInterpretation() {
    if (_bmiCat == BmiCat.severelyObese)
      return 'You are severely obese. Get professional help.';
    else if (_bmiCat == BmiCat.obese)
      return 'You are obese. Consider a strict diet and rigorous fitness regimen.';
    else if (_bmiCat == BmiCat.overweight)
      return 'You are overweight. Consider a healthier diet and perhaps some exercise.';
    else if (_bmiCat == BmiCat.healthy)
      return 'You are doing just fine. Keep it up!';
    else
      return 'You are underweight. Try eating more.';
  }
}
