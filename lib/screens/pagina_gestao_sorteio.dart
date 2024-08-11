import 'package:flutter/material.dart';
import 'package:poc_socket/screens/tela4_screen.dart';
import 'package:poc_socket/utils/timer_generico.dart';

class PaginaGestaoSorteio extends StatelessWidget {
  const PaginaGestaoSorteio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MeuDrawer(),
      appBar: AppBar(
        title: const Text('Gestão de Sorteio'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot),
            label: 'Bolas Sorteadas',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Botoes()
          ],
        ),
      ),
    );
  }
}

class Botoes extends StatelessWidget {
  const Botoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            TimerGenerico(context).start();
          },
          child: const Text('Liga Sorteio Automatico'),
        ),
      ],

    );
  }
}


  class MeuDrawer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return ListView(
        children: [
          ListTile(
            title: Text('Tela 4'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Tela4Screen()),
              );
            },
          ),
        ],
      );
    }
  }
