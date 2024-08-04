import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class Tela1 extends StatefulWidget {
  const Tela1({super.key});
  

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {


  
  @override
  void initState()  {
    super.initState();
       final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade');
      // final wsUrlx = Uri.parse('ws://localhost:8080/websocket');
       final wsUrlx = Uri.parse('ws://192.168.1.104:8080/gs-guide-websocket');
    final channel = WebSocketChannel.connect(wsUrl);

  

    streamListener(channel);
    
  }

  streamListener(channel) {

    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      print(message);
     
      setState(() {
        
        btcUsdtPrice = getData['p'];
      });

      // print(getData['p']);
      //  channel.sink.add('subscribe:geral');
      //  channel.sink.add(jsonEncode({
      //   'subscribe': '/topic/public'
      //  }));


    }, onError: (error) {
      print('Error: $error');
    }, onDone: () {
      print('Done');
    });


  }

  String btcUsdtPrice = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('Tela 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BTC/USDT Preço ",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 30),
            ),
            Text(
              btcUsdtPrice,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 194, 25),fontSize: 30
              ),
            ),
          ],
        ),
      ),
    );
  }
}