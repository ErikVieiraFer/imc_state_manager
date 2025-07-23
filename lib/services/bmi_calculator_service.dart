import 'dart:math';

import 'package:flutter/material.dart';


class BmiCalculatorService {
  
  static double calculateBmi(double weight, double height) {
    
    if (height <= 0) {
      return 0;
    }
    return weight / pow(height, 2);
  }

  
  static (String, Color) getBmiResult(double bmi) {
    if (bmi < 18.5) {
      return ('Underweight', Colors.blue);
    } else if (bmi < 25) {
      return ('Normal weight', Colors.green);
    } else if (bmi < 30) {
      return ('Overweight', Colors.orange);
    } else if (bmi < 35) {
      return ('Obesity Class I', Colors.deepOrange);
    } else if (bmi < 40) {
      return ('Obesity Class II', Colors.red);
    } else {
      return ('Obesity Class III', Colors.red.shade900);
    }
  }
}

