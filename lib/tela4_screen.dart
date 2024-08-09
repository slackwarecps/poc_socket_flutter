import 'dart:io';

import 'package:flutter/material.dart';
import 'package:poc_socket/utils/Env.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class Tela4Screen extends StatefulWidget {
  const Tela4Screen({super.key});

  @override
  State<Tela4Screen> createState() => _Tela4ScreenState();
}

class _Tela4ScreenState extends State<Tela4Screen> {
  late IO.Socket socket;
  //This will give platofrm specific url for ios and android emulator
  String socketUrl() {
    return Env.apiUrl;
  }

  @override
  void initState() {
    initSocket();
    super.initState();

    print('[#inicio] iniciou o app');
     print('[#apiUrl] iniciou o app ${Env.apiUrl}');
  }

  @override
  Widget build(BuildContext context) {
    bool socketConectado=false;




    return Scaffold(
      appBar: AppBar(
        title: const Text('** Tela 4 Screen **'),
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: 'Digite o texto aqui',
        ),
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

    socket.on('my_response', (data) => print(data));



    @override
    void dispose() {
      socket.disconnect();
      socket.dispose();
      super.dispose();
    }
  }

sendMessage() {
  String message = 'ola amiguinho..';
  if (message.isEmpty) return;
  Map messageMap = {
    'data': message,
    'time': DateTime.now().millisecondsSinceEpoch,
  };
  socket.emit('my_broadcast_event', messageMap);
}
}
