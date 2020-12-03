import 'package:flutter/material.dart';

Widget mostrarFilme(titulo, diretor, ano, preco, capa){
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.all(10),
      width: 160,
      child: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Image.asset( // Layout quadrado
              capa, 
              height: 234,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 295,
            child: Column(children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 75, // =(qtd linhas  * 25)
                child: Text(titulo, style: TextStyle(fontSize: 24))
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 40, // =(qtd linhas  * 20)
                child: Text(diretor + ' • ' + ano.toString(), style: TextStyle(fontSize: 20, color: Colors.grey[500]) )
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(preco, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),
            ]),
          ),
        ],
      ),
    ),
  );
}