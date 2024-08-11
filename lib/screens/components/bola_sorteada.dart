import 'package:flutter/material.dart';
import 'package:poc_socket/store/bola_evento.dart';
import 'package:poc_socket/store/sorteio_evento.dart';

class BolaSorteada extends StatelessWidget {
  //evento
  final BolaEvento evento;

  //construtor
  const BolaSorteada({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    final bola = evento.bola;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: CircularProgressIndicator(
            value: bola / 100,
            strokeWidth: 15,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Positioned(
          bottom: 60,
          child: Text("Algum texto aqui",style: TextStyle(fontSize: 18),)),
        Center(
          child: Text(
           bola.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}