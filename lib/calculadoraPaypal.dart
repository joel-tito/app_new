import 'package:flutter/material.dart';

class CalculadoraPaypal extends StatefulWidget {
  @override
  _CalculadoraPaypalState createState() => _CalculadoraPaypalState();
}

class _CalculadoraPaypalState extends State<CalculadoraPaypal>{
  double amountToReceive = 0.0;
  double commissionPercentage = 5.4;
  double fixedCommission = 0.30;
  double totalCommission = 0.0;
  double amountToSend = 0.0;

  double montoRecibido = 0.0;
  double comisionEnv = 13.0;
  double totalComision = 0.0;
  double montoEnviar = 0.0;
  double ganancia = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Comisiones PayPal'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('Las Comisiones PayPal',
              //style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //),
            //SizedBox(height: 10),
            //Text('5,4% más \$0,30 USDs'),
            //SizedBox(height: 20),
            Text(
              'Calculadora PayPal para Recibir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Para Recibir (USDs)',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  amountToReceive = double.tryParse(value) ?? 0.0;
                  calculateCommission();
                });
              },
            ),
            SizedBox(height: 10),
            Text('Hay que Enviar: \$${amountToSend.toStringAsFixed(2)} USDs'),
            SizedBox(height: 10),
            Text('La Comisión es de: \$${totalCommission.toStringAsFixed(2)} USDs'),

            SizedBox(height: 40),
            Text(
              'PayPal para enviar al Cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Si el cliente Envia (USDs)',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  montoRecibido = double.tryParse(value) ?? 0.0;
                  calculateCommissionEnvio();
                });
              },
            ),
            SizedBox(height: 10),
            Text('Recibira: \$${montoEnviar.toStringAsFixed(2)} USDs'),
            SizedBox(height: 10),
            Text('La Comisión es de: \$${totalComision.toStringAsFixed(2)} USDs'),
            SizedBox(height: 10),
            Text('La Ganacia es de: \$${ganancia.toStringAsFixed(2)} USDs'),
          ],
        ),
      ),
    );
  }

  void calculateCommission() {
    double percentageCommission = (amountToReceive * commissionPercentage) / 100;
    totalCommission = percentageCommission + fixedCommission;
    amountToSend = amountToReceive + totalCommission;
  }

    void calculateCommissionEnvio() {
    double percentageCommission = (montoRecibido * comisionEnv) / 100;
    double comisionPaypal = (montoRecibido * commissionPercentage) / 100;
    ganancia = percentageCommission - comisionPaypal;
    totalComision = percentageCommission + fixedCommission;
    montoEnviar = montoRecibido - totalComision;
  }
}
