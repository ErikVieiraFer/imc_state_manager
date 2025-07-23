import 'dart:async';

import 'package:flutter_default_state_manager/blocPattern/bmi_state.dart';
import 'package:flutter_default_state_manager/services/bmi_calculator_service.dart';

class BmiBlocPatternController {
  final _bmiStateStreamController = StreamController<BmiState>.broadcast()
    ..add(BmiState());

  Stream<BmiState> get bmiState => _bmiStateStreamController.stream;

  Future<void> calculateBmi(
      {required double weight, required double height}) async {
    _bmiStateStreamController.add(BmiState(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    final calculatedImc = BmiCalculatorService.calculateBmi(weight, height);
    final result = BmiCalculatorService.getBmiResult(calculatedImc);

    _bmiStateStreamController.add(
      BmiState(imc: calculatedImc, bmiResult: result, isLoading: false),
    );
  }

  void dispose() {
    _bmiStateStreamController.close();
  }
}
