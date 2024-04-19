import 'package:flutter/material.dart';

class CalculadoraPaypal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calculadora PayPal',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              fila('Si se envian:'),
              fila('La comision es de:'),
              fila('Se reciben:'),
              fila('Se gana:')
            ],
          ),
        ),
      ),
    );
  }
}

Widget fila(String text1) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Text(text1, style: TextStyle(fontSize: 18)),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    ),
  );
}
