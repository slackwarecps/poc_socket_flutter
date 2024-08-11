import 'package:flutter/material.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:poc_socket/screens/components/bola_sorteada.dart';
import 'package:poc_socket/store/bola_evento.dart';
import 'package:poc_socket/store/end_evento.dart';
import 'package:poc_socket/store/sorteio_controller.dart';
import 'package:poc_socket/store/sorteio_evento.dart';
import 'package:poc_socket/store/start_evento.dart';

class PaginaCinco extends StatefulWidget {
  const PaginaCinco({super.key});

  @override
  State<PaginaCinco> createState() => _PaginaCincoState();
}

class _PaginaCincoState extends State<PaginaCinco> {
  bool mostraStartButton = true;
  late final SorteioController controller;
  late final Stream<SorteioEvento> sorteioStream;

  start() {
    controller = SorteioController(sorteioLista: [
      Bola(numero: 22, texto: "dois patinhos na lagoa"),
      Bola(numero: 11, texto: "perna de moça bonita"),
      Bola(numero: 7, texto: "Baixinho e mentiroso"),
    ]);

    setState(() {
      sorteioStream = controller.start();
      mostraStartButton = false;
    });
  }

  //construcao do componente
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Cinco'),
      ),
      body: Center(
        child: mostraStartButton
            ? ElevatedButton(
                onPressed: start,
                child: const Text("Iniciar Sorteio"),
              )
            : StreamBuilder(
                stream: sorteioStream,
                builder: (context, AsyncSnapshot<SorteioEvento> snapshot) {
                  //Pega o Evento recebido no stream.
                  SorteioEvento? evento = snapshot.data;

                  if (snapshot.hasError) {
                    return const Text("ERRO AO LER O SORTEIO...");
                  } else if (evento is StartEvento) {
                    return const Text("Sorteio iniciado...");
                  } else if (evento is EndEvento) {
                    return const Text("Sorteio finalizado...");
                  } else if (evento is BolaEvento) {
                    return BolaSorteada(evento: evento);
                  } else {
                    return Container();
                  }
                },
              ),
      ),
    );
  }
}
