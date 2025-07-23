import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/services/bmi_calculator_service.dart';

class BmiChangeNotifier extends ChangeNotifier {
  double _imc = 0.0;
  double get imc => _imc;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  (String, Color)? _bmiResult;
  (String, Color)? get bmiResult => _bmiResult;

  Future<void> calculateBmi(
      {required double weight, required double height}) async {
    _isLoading = true;
    _imc = 0;
    _bmiResult = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _imc = BmiCalculatorService.calculateBmi(weight, height);
    _bmiResult = BmiCalculatorService.getBmiResult(_imc);
    _isLoading = false;
    notifyListeners();
  }
}

