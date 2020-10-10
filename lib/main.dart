import 'package:flutter/material.dart';
import 'package:flutter_app_andre/Screen/codigo_binario.dart';

void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('Teste - Calculadora de Binarios'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.indigo,
        ),
      ),
      home: CodigoBinario(),
    );
  }
}

