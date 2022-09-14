import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _textInfo = "";

  void _resetFild() {
    _formKey.currentState!.reset();
    pesoController.clear();
    alturaController.clear();
    setState(() {
      _textInfo = "";
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _textInfo = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textInfo = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textInfo = "Levemente acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFild,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.person, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu Peso!";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua Altura!";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ButtonTheme(
                  height: 50.0,
                  highlightColor: Colors.amber,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calculate();
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ),
              ),
              Text(
                _textInfo,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
