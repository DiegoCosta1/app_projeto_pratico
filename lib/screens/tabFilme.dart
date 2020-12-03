import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/filme.dart';
import '../components/mostrarFilme.dart';

//
//----------------- LIVROS
//
class TelaFilme extends StatefulWidget {
  @override
  _TelaFilmeState createState() => _TelaFilmeState();
}

class _TelaFilmeState extends State<TelaFilme> {

  var db = FirebaseFirestore.instance;
  List<Filme> filmes = List();

  // 'Listener' ~ 'Ouvinte': ouvir todos os eventos que ocorrem na coleção
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState(){
    super.initState();

    // Quando acontecer um 'evento' na coleção, recuperar TODOS os documentos
    listen?.cancel();
    listen = db.collection("filmes").snapshots().listen((res) { 

      // Converter todos os documentos em objetos
      setState(() {
        filmes = res.docs.map((e) => Filme.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("filmes").snapshots(),
        builder: (context, snapshot){
          
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return Center(child: Text('Erro de conexão!'));
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: filmes.length,
                itemBuilder: (context, index){
                  return mostrarFilme(filmes[index].titulo, filmes[index].diretor, filmes[index].ano, filmes[index].preco, filmes[index].capa);
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
          Navigator.pushNamed(context, "/cadastroFilme");
        },
      ),
    );
  }
}