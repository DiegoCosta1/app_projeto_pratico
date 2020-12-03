import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/jogo.dart';
import '../components/mostrarJogo.dart';

//
//----------------- LIVROS
//
class TelaJogo extends StatefulWidget {
  @override
  _TelaJogoState createState() => _TelaJogoState();
}

class _TelaJogoState extends State<TelaJogo> {

  var db = FirebaseFirestore.instance;
  List<Jogo> jogos = List();

  // 'Listener' ~ 'Ouvinte': ouvir todos os eventos que ocorrem na coleção
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState(){
    super.initState();


    // Quando acontecer um 'evento' na coleção, recuperar TODOS os documentos
    listen?.cancel();
    listen = db.collection("jogos").snapshots().listen((res) { 

      // Converter todos os documentos em objetos
      setState(() {
        jogos = res.docs.map((e) => Jogo.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("jogos").snapshots(),
        builder: (context, snapshot){
          
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return Center(child: Text('Erro de conexão!'));
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: jogos.length,
                itemBuilder: (context, index){
                  return mostrarJogo(jogos[index].titulo, jogos[index].desenvolvedora, jogos[index].ano, jogos[index].preco, jogos[index].capa);
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
          Navigator.pushNamed(context, "/cadastroJogo");
        },
      ),
    );
  }
}