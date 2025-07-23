import 'package:flutter/material.dart';

class BmiState {
  final double imc;
  final bool isLoading;
  final (String, Color)? bmiResult;

  BmiState({
    this.imc = 0.0,
    this.isLoading = false,
    this.bmiResult,
  });
}