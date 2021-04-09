import 'dart:math';

import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  String _resultadoImc;

  void calcularImc() {
    double altura = double.parse(alturaController.text) / 100;
    double peso = double.parse(pesoController.text);

    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoImc = imc.toStringAsFixed(2) + "\n\n" + getClassificacao(imc);
    });
  }

  String getClassificacao(num imc) {
    String classificacao;

    if (imc < 18.6)
      classificacao = "Abaixo do peso";
    else if (imc < 25)
      classificacao = "Peso ideal";
    else if (imc < 30)
      classificacao = "Levemente abaixo de peso";
    else if (imc < 35)
      classificacao = "Obesidade grau I";
    else if (imc < 40)
      classificacao = "Obesidade grau II";
    else
      classificacao = "Obesidade grau III";

    return classificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: alturaController,
                validator: (value) {
                  return value.isEmpty ? "Informe a altura" : null;
                },
                decoration: InputDecoration(
                  labelText: "Altura em cm",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  return value.isEmpty ? "Informe o peso" : null;
                },
                controller: pesoController,
                decoration: InputDecoration(
                  labelText: "Peso em Kg",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(_resultadoImc == null ? "" : "IMC $_resultadoImc"),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    calcularImc();
                  }
                },
                child: Text("Calcular"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
