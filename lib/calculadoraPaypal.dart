import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CalculadoraPaypal extends StatefulWidget {
  @override
  _CalculadoraPaypalState createState() => _CalculadoraPaypalState();
}

class _CalculadoraPaypalState extends State<CalculadoraPaypal>{
   // Declara un objeto Interpreter que se utilizará para cargar el modelo TensorFlow Lite.
  Interpreter? interpreter;

  // Variable para almacenar el valor de la predicción.
  var predValue = "";

  // Método initState, se llama cuando el widget se inserta en el árbol de widgets.
  @override
  void initState() {
    super.initState();
    // Inicializa el modelo TensorFlow Lite cuando se carga el widget.
    initModel();
  }

  // Método para inicializar el modelo TensorFlow Lite.
  initModel() async {
    // Carga el modelo TensorFlow Lite desde un archivo asset.
    final _interpreter = await Interpreter.fromAsset('modeloPaypal.tflite');
    setState(() {
      interpreter = _interpreter;
    });
  }

  // Método para obtener la predicción utilizando el modelo TensorFlow Lite.
  getPrediction(input){
    // Crea un tensor para almacenar la salida del modelo.
    var output = List.filled(1, 0).reshape([1, 1]);
    // Ejecuta el modelo TensorFlow Lite con la entrada proporcionada y almacena la salida en el tensor de salida.
    interpreter?.run(input, output);
    // Obtiene el valor de predicción de la salida del modelo y lo formatea.
    var prediccion = output[0][0].toStringAsFixed(1).toString();
    return prediccion;
  }
  
  double amountToReceive = 0.0;
  double commissionPercentage = 5.4;
  double fixedCommission = 0.30;
  double totalCommission = 0.0;
  double amountToSend = 0.0;
  double cobroRecibir = 0.0;
  double gananciaRecibir = 0.0;

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
            Text(
              'Cliente Recibe a Paypal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Para que el cliente Reciba (USDs) en Paypal',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {
                  amountToReceive = double.tryParse(value) ?? 0.0;
                  predValue = getPrediction([amountToReceive]);
                  calculateValorEnviar();
                });
              },
            ),
            SizedBox(height: 10),
            Text('Hay que Enviar: \$${predValue} USDs'),
            SizedBox(height: 10),
            Text('La Comisión es de: \$${totalCommission.toStringAsFixed(2)} USDs'),
            SizedBox(height: 10),
            Text('Se debe cobrar: \$${cobroRecibir.toStringAsFixed(2)} USDs'),
            SizedBox(height: 10),
            Text('La Ganacia es de: \$${gananciaRecibir.toStringAsFixed(2)} USDs'),
            
            SizedBox(height: 40),
            Text(
              'Cliente Envia a Paypal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Si el cliente Envia (USDs) a Paypal',
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

   void calculateValorEnviar() {
    double percentageCommission = double.parse(predValue) - amountToReceive;
    totalCommission = percentageCommission;
    cobroRecibir =  amountToReceive*1.20;
    gananciaRecibir = cobroRecibir - double.parse(predValue);
  }

  void calculateCommissionEnvio() {
    double percentageCommission = (montoRecibido * 13.0) / 100;
    double comisionPaypal = (montoRecibido * 5.0) / 100;
    montoEnviar = montoRecibido - totalComision;
    totalComision = percentageCommission + 0.30;
    ganancia = percentageCommission - comisionPaypal;
  }
}