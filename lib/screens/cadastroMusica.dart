import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/campoTexto.dart';

class TelaCadastroMusica extends StatefulWidget {
  @override
  _TelaCadastroMusicaState createState() => _TelaCadastroMusicaState();
}

class _TelaCadastroMusicaState extends State<TelaCadastroMusica> {

  // Variáveis de controle
  var txtTitulo = TextEditingController();
  var txtArtista = TextEditingController();
  var txtAno = TextEditingController();
  var txtCapa = TextEditingController();
  
  var txtPreco = TextEditingController();

  // conexão com o banco
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Música"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),

      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(children: [

          // CAMPOS DE TEXTO
          campoTexto("Título", txtTitulo, null, false, context),
          SizedBox(height: 5),
          campoTexto("Artista", txtArtista, null, false, context),
          SizedBox(height: 5),
          campoTexto("Ano", txtAno, null, false, context),
          SizedBox(height: 5),
          campoTexto("Preco", txtPreco, null, false, context),
          SizedBox(height: 5),
          campoTexto("Capa", txtCapa, null, false, context),
          SizedBox(height: 30),
          
          // BOTÕES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 30,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Salvar", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: () async {
                    // SALVAR
                    await db.collection("musicas").add(
                      {
                        "titulo" : txtTitulo.text,
                        "preco" : txtPreco.text,
                        "artista" : txtArtista.text,
                        "ano" : txtAno.text,
                        "capa" :  txtCapa.text,
                      }
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 150,
                height: 30,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text("Cancelar", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],),
      ),
    );
  }
}