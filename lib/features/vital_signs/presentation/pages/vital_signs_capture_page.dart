import 'package:flutter/material.dart';

class VitalSignsCapturePage extends StatelessWidget {
  const VitalSignsCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signos vitales')),
      body: const Center(
        child: Text('Pantalla fake de captura de signos vitales'),
      ),
    );
  }
}
