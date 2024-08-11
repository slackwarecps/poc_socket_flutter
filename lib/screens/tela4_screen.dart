
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poc_socket/dao/sorteio_repository.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:poc_socket/screens/pagina_bolas_sorteadas.dart';
import 'package:poc_socket/utils/Env.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Tela4Screen extends StatefulWidget {
  const Tela4Screen({super.key});

  @override
  State<Tela4Screen> createState() => _Tela4ScreenState();
}

class _Tela4ScreenState extends State<Tela4Screen> {
  late IO.Socket socket;
  late SorteioRepository bolasSorteadas;

  String socketUrl() {
    return "https://fabao-socketserverpoc.up.railway.app/";
    //return Env.apiUrl;
  }

    void timer() async {
    var random = Random();
    while (true) {
      var randomico = random.nextInt(200);
      await Future.delayed(Duration(seconds: 5));
      debugPrint('assincrono : #tela4 :: Número randomico: ${randomico}');
      bolasSorteadas.addBola(Bola(numero: randomico, texto: "Automatico"));
    }
  }

  @override
  void initState() {
    initSocket();
    super.initState();

    print('[#inicio] iniciou o app');
    print('[#apiUrl] iniciou o app ${Env.apiUrl}');
  //  timer();
  }

  limparSelecionadas() {
    setState(() {
      debugPrint("Nao limpou nada.");
    });
  }

  @override
  Widget build(BuildContext context) {
    //recuperar o valor do provider
    // var sorteioRepository = Provider.of<SorteioRepository>(context).bolasSorteadas;
    // bolasSorteadas = context.watch<SorteioRepository>();
    bolasSorteadas = Provider.of<SorteioRepository>(context);
//ouve as mudancas

    return Scaffold(
      appBar: AppBar(
        title: const Text('** Tela 4 Screen **'),
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Digite o texto aqui',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print("vai chamar a pagina de bolas sorteadas");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaginaBolasSorteadas()),
              );
            },
            child: const Text('Bolas Sorteadas Page'),
          ),
          ElevatedButton(
            onPressed: () {
              bolasSorteadas.saveAll([
                Bola(numero: 33, texto: "Idade de Cristo"),
                Bola(numero: 22, texto: "Dois patinhos na lagoa"),
                Bola(numero: 15, texto: "moça bonita"),
                Bola(numero: 7, texto: "baixinho e mentiroso"),
              ]);
              print("adicionou a bola");
              setState(() {
                debugPrint("nao limpou nada.");
              });
              limparSelecionadas();
            },
            child: const Text('Bola varias'),
          ),
          ElevatedButton(
            onPressed: () {
              bolasSorteadas.addBola(Bola(numero: 33, texto: "Idade de Cristo"));
              print("adicionou a bola ");

            },
            child: const Text('+ Bola'),
          ),
          Divider(
            // A linha que separa os elementos
            color: Colors.black,
            thickness: 10,
          ),
          Text("Numeros Sorteados: ${bolasSorteadas.lista.toString()}"),
          Text("Contador: ${bolasSorteadas.getContador}"),
          Text('ALGUM TEXT ${context.watch<SorteioRepository>().getStatus}'),
          Text(
              'Ultima Bola: ${context.watch<SorteioRepository>().getUltimaBola.numero.toString()}'),
        ],
      ),
      floatingActionButton: socket.connected
          ? FloatingActionButton(
              onPressed: () {
                sendMessage();
              },
              child: const Icon(Icons.send),
            )
          : FloatingActionButton(
              onPressed: () {
                sendMessage();
              },
              child: const Icon(Icons.connect_without_contact),
            ),
    );
  }

  void initSocket() {
    socket = IO.io(socketUrl(), <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
      'extraHeaders': {'meu-codigo': '77777777'},
    });
    socket.connect();
   // socket.disconnect();

    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));

    socket.onConnect((_) {
      print('connect');
      socket.emit('my_event', 'test');
    });

    socket.on('my_event', (data) => print(data));

    // RECEBE O BROADCAST
    socket.on('my_response', (dadosRecebidos) {
      try {
         if (dadosRecebidos['data'] == null || dadosRecebidos['data']['bola'] == null) {
         print('Dados recebidos do socket não contêm um objeto bola.');
        } else if  (dadosRecebidos['data']['bola'] != null) {
        int numero = dadosRecebidos['data']['bola']['numero'];
        String texto = dadosRecebidos['data']['bola']['texto'];
        bolasSorteadas.addBola(Bola(numero: numero, texto: texto));
        print('2 Dados recebidos do socket: ${dadosRecebidos} ');
      } 



      } catch (e) {
        print('Erro ao receber dados do socket: ${e}');
      }
     


    
      if (dadosRecebidos['data']=='Connected') {
        print('1 Dados recebidos do socket: ${dadosRecebidos} ');
      } else {
        print('3 NULL: Dados recebidos do socket: ${dadosRecebidos} ');
      }
    });

    @override
    void dispose() {
      socket.disconnect();
      socket.dispose();
      super.dispose();
    }
  }

  sendMessage() {
    String message = 'ola amiguinho do Flutter..';
    if (message.isEmpty) return;
    Map dados = {
      'data': Bola(numero: 44, texto: "quarenta e quatro").toMap(),
    };
    socket.emit('my_broadcast_event', dados);
  }
}
