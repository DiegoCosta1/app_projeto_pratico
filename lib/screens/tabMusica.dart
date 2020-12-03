import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/musica.dart';
import '../components/mostrarMusica.dart';

//
//----------------- MÚSICAS
//
class TelaMusica extends StatefulWidget {
  @override
  _TelaMusicaState createState() => _TelaMusicaState();
}

class _TelaMusicaState extends State<TelaMusica> {

  var db = FirebaseFirestore.instance;
  List<Musica> musicas = List();

  // 'Listener' ~ 'Ouvinte': ouvir todos os eventos que ocorrem na coleção
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState(){
    super.initState();


    // Quando acontecer um 'evento' na coleção, recuperar TODOS os documentos
    listen?.cancel();
    listen = db.collection("musicas").snapshots().listen((res) { 

      // Converter todos os documentos em objetos
      setState(() {
        musicas = res.docs.map((e) => Musica.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("musicas").snapshots(),
        builder: (context, snapshot){
          
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return Center(child: Text('Erro de conexão!'));
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: musicas.length,
                itemBuilder: (context, index){
                  return mostrarMusica(musicas[index].titulo, musicas[index].artista, musicas[index].ano, musicas[index].preco, musicas[index].capa);
                },
              );
          } // Switch
        },
      ),

      // BOTÃO PARA ADICIONAR ITENS
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/cadastroMusica");
        },
      ),
    );
  }
}