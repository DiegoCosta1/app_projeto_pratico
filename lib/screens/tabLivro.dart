import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/livro.dart';
import '../components/mostrarLivro.dart';

//
//----------------- LIVROS
//
class TelaLivro extends StatefulWidget {
  @override
  _TelaLivroState createState() => _TelaLivroState();
}

class _TelaLivroState extends State<TelaLivro> {

  var db = FirebaseFirestore.instance;
  List<Livro> livros = List();

  // 'Listener' ~ 'Ouvinte': ouvir todos os eventos que ocorrem na coleção
  StreamSubscription<QuerySnapshot> listen;

  @override
  void initState(){
    super.initState();


    // Quando acontecer um 'evento' na coleção, recuperar TODOS os documentos
    listen?.cancel();
    listen = db.collection("livros").snapshots().listen((res) { 

      // Converter todos os documentos em objetos
      setState(() {
        livros = res.docs.map((e) => Livro.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("livros").snapshots(),
        builder: (context, snapshot){
          
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return Center(child: Text('Erro de conexão!'));
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: livros.length,
                itemBuilder: (context, index){
                  return mostrarLivro(livros[index].titulo, livros[index].autor, livros[index].ano, livros[index].preco, livros[index].capa);
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
          Navigator.pushNamed(context, "/cadastroLivro");
        },
      ),
    );
  }
}