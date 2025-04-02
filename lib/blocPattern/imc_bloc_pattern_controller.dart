import 'dart:async';
import 'dart:math';

import 'package:flutter_default_state_manager/blocPattern/imc_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcStates>.broadcast()
    ..add(ImcStates(imc: 0));
  Stream<ImcStates> get imcOut => _imcStreamController.stream;

  //valores só serão adicionados através da controler, variável privada

  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    _imcStreamController.add(ImcStateLoadind());
    await Future.delayed(Duration(seconds: 1));
    final imc = peso / pow(altura, 2);
    _imcStreamController.add(ImcStates(imc: imc));
  }

  void dispose() {
    _imcStreamController.close();
  }
}
