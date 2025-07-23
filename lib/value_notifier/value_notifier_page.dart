import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/services/bmi_calculator_service.dart';
import 'package:flutter_default_state_manager/widgets/bmi_text_field.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ValueNotifierPage extends StatefulWidget {
  const ValueNotifierPage({Key? key}) : super(key: key);

  @override
  State<ValueNotifierPage> createState() => _ValueNotifierPageState();
}

class _ValueNotifierPageState extends State<ValueNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final imcNotifier = ValueNotifier<double>(0.0);
  final isLoadingNotifier = ValueNotifier<bool>(false);
  final bmiResultNotifier = ValueNotifier<(String, Color)?>(null);

  Future<void> _calculateBmi(
      {required double peso, required double altura}) async {
    isLoadingNotifier.value = true;
    imcNotifier.value = 0;
    bmiResultNotifier.value = null;

    await Future.delayed(const Duration(seconds: 1));

    final calculatedImc = BmiCalculatorService.calculateBmi(peso, altura);
    imcNotifier.value = calculatedImc;
    bmiResultNotifier.value = BmiCalculatorService.getBmiResult(calculatedImc);

    isLoadingNotifier.value = false;
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    imcNotifier.dispose();
    isLoadingNotifier.dispose();
    bmiResultNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator (ValueNotifier)'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: imcNotifier,
                  builder: (_, imcValue, __) => ImcGauge(imc: imcValue),
                ),
                ValueListenableBuilder<(String, Color)?>(
                  valueListenable: bmiResultNotifier,
                  builder: (_, bmiResultValue, __) {
                    if (bmiResultValue == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        bmiResultValue.$1,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: bmiResultValue.$2),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BmiTextField(label: 'Weight (kg)', controller: pesoEC),
                const SizedBox(height: 20),
                BmiTextField(label: 'Height (m)', controller: alturaEC),
                const SizedBox(height: 20),
                ValueListenableBuilder<bool>(
                  valueListenable: isLoadingNotifier,
                  builder: (_, isLoadingValue, __) {
                    return ElevatedButton(
                      onPressed: isLoadingValue
                          ? null
                          : () {
                              final formValid =
                                  formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                final formatter = NumberFormat.simpleCurrency(
                                    locale: 'pt_BR', decimalDigits: 2);
                                final peso =
                                    formatter.parse(pesoEC.text) as double;
                                final altura =
                                    formatter.parse(alturaEC.text) as double;
                                _calculateBmi(peso: peso, altura: altura);
                              }
                            },
                      child: isLoadingValue
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Calculate BMI'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
