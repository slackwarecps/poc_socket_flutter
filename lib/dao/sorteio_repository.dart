import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:poc_socket/screens/pagina_seis.dart';

//PROVIDER!!!!

class SorteioRepository extends ChangeNotifier {
  List<Bola> _lista = [];

  UnmodifiableListView<Bola> get lista => UnmodifiableListView(_lista);

  saveAll(List<Bola> bolas) {
    bolas.forEach((bola) {  
      if (!_lista.contains(bola)) _lista.add(bola);
      contador++;
      });
    notifyListeners();
  }

  String status = "iniciado";
  int contador = 0;
  Bola ultimaBola = Bola(numero: 0, texto: "Zero");

  void setBola(Bola bola) {
    ultimaBola = bola;
    notifyListeners();
  }

  String get getStatus => status;
  Bola get getUltimaBola => ultimaBola;
  int get getContador => contador;

  addBola(Bola bola) {
    _lista.add(bola);
    contador++;
    notifyListeners();
  }

  remove(int bola) {
    _lista.remove(bola);
    notifyListeners();
  }
}
