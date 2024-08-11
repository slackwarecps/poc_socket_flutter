import 'dart:math';

import 'package:flutter/widgets.dart'; // Importing from the public 'flutter' library instead of 'flutter/src/widgets/framework.dart'
import 'package:poc_socket/dao/sorteio_repository.dart';
import 'package:poc_socket/models/bola.dart';
import 'package:provider/provider.dart';

class TimerGenerico {
  late BuildContext context;
  late SorteioRepository bolasSorteadas;
  TimerGenerico(this.context){
  
    bolasSorteadas = Provider.of<SorteioRepository>(this.context); // Removing the unnecessary 'this.' qualifier.

  }// Using an initializing formal to assign the parameter to the field.

  void start() async {
    
    var random = Random();
    while (true) {
      var randomico = random.nextInt(200);
      await Future.delayed(const Duration(seconds: 5)); // Adding the 'const' keyword to improve performance.

      // debugPrint('assincrono : #tela4 :: Número randomico: ${randomico}');
      bolasSorteadas.addBola(Bola(numero: randomico, texto: "Automatico"));
    }
  }
}
