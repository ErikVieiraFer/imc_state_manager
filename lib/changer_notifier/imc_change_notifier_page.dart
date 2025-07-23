import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/changer_notifier/bmi_change_notifier.dart';
import 'package:flutter_default_state_manager/widgets/bmi_text_field.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final notifier = BmiChangeNotifier();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('BMI Calculator (ChangeNotifier)'),
            backgroundColor: Colors.orange,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ImcGauge(imc: notifier.imc),
                    if (notifier.bmiResult != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          notifier.bmiResult!.$1,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: notifier.bmiResult!.$2,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 20),
                    BmiTextField(label: 'Weight (kg)', controller: pesoEC),
                    const SizedBox(height: 20),
                    BmiTextField(label: 'Height (m)', controller: alturaEC),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: notifier.isLoading
                          ? null
                          : () {
                              final formValid =
                                  formKey.currentState?.validate() ?? false;
                              if (formValid) {
                                final formatter = NumberFormat.simpleCurrency(
                                    locale: 'pt_BR', decimalDigits: 2);
                                final weight =
                                    formatter.parse(pesoEC.text) as double;
                                final height =
                                    formatter.parse(alturaEC.text) as double;
                                notifier.calculateBmi(
                                    weight: weight, height: height);
                              }
                            },
                      child: notifier.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Calculate BMI'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
