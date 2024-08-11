import 'package:flutter/material.dart';
import 'package:poc_socket/dao/sorteio_repository.dart';
import 'package:poc_socket/screens/components/bola_card.dart';
import 'package:provider/provider.dart';

class PaginaBolasSorteadas extends StatefulWidget {
  const PaginaBolasSorteadas({super.key});

  @override
  State<PaginaBolasSorteadas> createState() => _PaginaBolasSorteadasState();
}

class _PaginaBolasSorteadasState extends State<PaginaBolasSorteadas> {
   late SorteioRepository bolasSorteadas;
  @override
  Widget build(BuildContext context) {
    bolasSorteadas = Provider.of<SorteioRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('Bolas Sorteadas ${bolasSorteadas.getContador}'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12),
        color: Colors.indigo.withOpacity(0.05),
        child: Consumer<SorteioRepository>(
          builder: (context, bolasSorteadas, child) {
            return bolasSorteadas.lista.isEmpty
                ? const ListTile(
                    leading: Icon(
                      Icons.browse_gallery_sharp,
                      size: 32,
                    ),
                    title: Text('NENHUMA BOLA SORTEADA'),
                  )
                : ListView.builder(
                    itemCount: bolasSorteadas.lista.length,
                    itemBuilder: (context, index) {
                      return BolaCard(bola: bolasSorteadas.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
