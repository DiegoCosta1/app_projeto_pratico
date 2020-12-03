import 'package:flutter/material.dart';

Widget mostrarMusica(titulo, artista, ano, preco, capa){
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
              width: 160,
              height: 160,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 310,
            child: Column(children: [
              /*
              ListTile(
                title: Text(musicas[index].titulo, style: TextStyle(fontSize: 24),),
                subtitle: Text(musicas[index].artista, style: TextStyle(fontSize: 24),),  
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: (){

                    // APAGAR UM DOCUMENTO
                    //db.collection("cafes").doc(musicas[index].id).delete();
                  },
                ),
              )*/
              
              Container(
                alignment: Alignment.bottomLeft,
                height: 75, // =(qtd linhas  * 25)
                child: Text(titulo, style: TextStyle(fontSize: 24))
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 40, // =(qtd linhas  * 20)
                child: Text(artista + ' • ' + ano.toString(), style: TextStyle(fontSize: 20, color: Colors.grey[500]) )
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