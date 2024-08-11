import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poc_socket/dao/sorteio_repository.dart';
import 'package:poc_socket/screens/pagina_cinco.dart';
import 'package:poc_socket/screens/pagina_gestao_sorteio.dart';
import 'package:poc_socket/screens/pagina_seis.dart';
import 'package:provider/provider.dart';

import 'package:poc_socket/screens/tela4_screen.dart';

void main() {
 

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SorteioRepository(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket POC Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const PaginaGestaoSorteio(),
    );
  }
}
