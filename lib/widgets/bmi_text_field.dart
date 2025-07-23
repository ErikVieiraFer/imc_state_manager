import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class BmiTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BmiTextField({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      inputFormatters: [
        CurrencyTextInputFormatter.currency(
          locale: 'pt_BR', 
          symbol: '',
          turnOffGrouping: true,
          decimalDigits: 2,
        ),
      ],
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}