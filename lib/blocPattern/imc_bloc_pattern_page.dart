import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blocPattern/bmi_state.dart';
import 'package:flutter_default_state_manager/blocPattern/imc_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/widgets/bmi_text_field.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final bloc = BmiBlocPatternController();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI (Bloc Pattern)'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<BmiState>(
                stream: bloc.bmiState,
                builder: (context, snapshot) {
                  final state = snapshot.data ?? BmiState();
                  return Column(
                    children: [
                      ImcGauge(imc: state.imc),
                      if (state.bmiResult != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            state.bmiResult!.$1,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: state.bmiResult!.$2,
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
                        onPressed: state.isLoading
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
                                  bloc.calculateBmi(
                                      weight: weight, height: height);
                                }
                              },
                        child: state.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Calculate BMI'),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
