import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:poc_socket/store/bola_evento.dart';
import 'package:poc_socket/store/end_evento.dart';
import 'package:poc_socket/store/sorteio_evento.dart';
import 'package:poc_socket/store/start_evento.dart';

class SorteioController {
  List<Bola> sorteioLista = [];

  var contador = 0;

  SorteioController({required this.sorteioLista});

//Retorna um stream de String
  Stream<SorteioEvento> start() async* {
    yield StartEvento();

    var random = Random();

    while (contador < 5) {
      var bolaSorteada = random.nextInt(100);
      await Future.delayed(Duration(seconds: 1));
      yield BolaEvento(bola: bolaSorteada);
      debugPrint('Número sorteado: ${bolaSorteada}');

      contador++;
    }

    yield EndEvento();
  }
  
}
