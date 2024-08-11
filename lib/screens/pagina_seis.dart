import 'package:flutter/material.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:poc_socket/screens/components/bola_sorteada.dart';
import 'package:poc_socket/store/bola_evento.dart';
import 'package:poc_socket/store/end_evento.dart';
import 'package:poc_socket/store/sorteio_controller.dart';
import 'package:poc_socket/store/sorteio_evento.dart';
import 'package:poc_socket/store/start_evento.dart';
import 'package:provider/provider.dart';

import '../dao/sorteio_repository.dart';

class PaginaSeis extends StatefulWidget {
  const PaginaSeis({super.key});

  @override
  State<PaginaSeis> createState() => _PaginaSeisState();
}

class _PaginaSeisState extends State<PaginaSeis> {
  bool mostraStartButton = true;
  late final SorteioController controller;
  late final Stream<SorteioEvento> sorteioStream;
  late SorteioRepository sorteioRepository;

  start() {
    
  }

  //construcao do componente
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina Cinco'),
      ),
      body: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [



          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ultima Bola ${context.watch<SorteioRepository>().getUltimaBola}'),
            ],
          ),


          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Count(),
            ],
          ),

         Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             ElevatedButton(onPressed: (){
                print("clicou no botao");
                context.read<SorteioRepository>().setBola(Bola(numero: 15, texto: "Moça bonita"));
             }, child: const Text("data"))
            ],
          ),


        ],)

    );
  }
}


class Count extends StatelessWidget {
  const Count({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      '${context.watch<SorteioRepository>().getUltimaBola}',
      key: const Key('counterState'),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}