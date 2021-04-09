import 'package:aula_imc/widgets/calculoimc_widget.dart';
import 'package:flutter/material.dart';

class CalculoImcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo IMC"),
      ),
      body: CalculoImcWidget(),
    );
  }
}
