import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/bmi_text_field.dart';
import 'package:flutter_default_state_manager/services/bmi_calculator_service.dart';
import 'package:intl/intl.dart';

class ImcSetStatePage extends StatefulWidget {
  const ImcSetStatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetStatePage> createState() => _ImcSetStatePageState();
}

class _ImcSetStatePageState extends State<ImcSetStatePage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;
  var _isLoading = false;
  (String, Color)? _bmiResult;

  Future<void> _calcularIMC(
      {required double peso, required double altura}) async {
    setState(() {
      imc = 0;
      _isLoading = true;
      _bmiResult = null;
    });

    await Future.delayed(
      Duration(seconds: 1),
    );

    final calculatedImc = BmiCalculatorService.calculateBmi(peso, altura);

    setState(() {
      imc = calculatedImc;
      _bmiResult = BmiCalculatorService.getBmiResult(imc);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator (setState)'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ImcGauge(imc: imc),
                if (_bmiResult != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _bmiResult!.$1,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: _bmiResult!.$2,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                BmiTextField(label: 'Weight (kg)', controller: pesoEC),
                const SizedBox(height: 20),
                BmiTextField(label: 'Height (m)', controller: alturaEC),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : () {
                    var formValid = formKey.currentState?.validate() ?? false;
                    if (formValid) {
                      var formater = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double peso = formater.parse(pesoEC.text) as double;
                      double altura = formater.parse(alturaEC.text) as double;
                      _calcularIMC(peso: peso, altura: altura);
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Calculate BMI'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
