import 'package:flutter/material.dart';
import 'package:poc_socket/models/bola.dart';

class BolaCard extends StatefulWidget {
  Bola bola;
  BolaCard({super.key, required this.bola});

  @override
  State<BolaCard> createState() => _BolaCardState();
}

class _BolaCardState extends State<BolaCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top:12),
      child: Row(
        children: [
          Icon(Icons.circle_notifications, size: 40,),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.bola.numero.toString(), style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                   Text(widget.bola.texto.toString(), style: TextStyle(fontSize: 13,color: Colors.black),),
                ],
              ),
            ),
          ),
        ],
      )
          
    );
  
    
    
  }
}