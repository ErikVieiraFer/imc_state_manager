import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/blocPattern/imc_bloc_pattern_page.dart';
import 'package:flutter_default_state_manager/changer_notifier/imc_change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_setstate_page.dart';
import 'package:flutter_default_state_manager/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => _goToPage(context, const ImcSetStatePage()),
                child: const Text('setState'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _goToPage(context, const ValueNotifierPage()),
                child: const Text('ValueNotifier'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ImcChangeNotifierPage()),
                child: const Text('ChangeNotifier'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _goToPage(context, const ImcBlocPatternPage()),
                child: const Text('Bloc Pattern (Streams)'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
