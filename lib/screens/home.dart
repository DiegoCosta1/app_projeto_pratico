import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/usuario.dart';
import 'tabFilme.dart';
import 'tabJogo.dart';
import 'tabLivro.dart';
import 'tabMusica.dart';
/*import 'about.dart';
import 'cadastroFilme.dart';
import 'cadastroMusica.dart';
import 'cadastroLivro.dart';
import 'cadastroJogo.dart';*/

class TelaPrincipal extends StatefulWidget {
  @override
  
  _TelaPrincipalState createState() => _TelaPrincipalState();
}


class _TelaPrincipalState extends State<TelaPrincipal> {

  String nomeUsuario;
  String emailUsuario;

  // Conexão com o banco
  var db = FirebaseFirestore.instance;

  List<Usuario> usuarios = List();

  StreamSubscription<QuerySnapshot> ouvidor;

   @override
  void initState(){
    super.initState();

    //Registrar o "ouvidor" para monitorar qualquer tipo de alteração
    //na coleção Usuarios do FireStore
    ouvidor?.cancel();

    ouvidor = db.collection("usuarios").snapshots().listen( (res) {

      setState(() {
        usuarios = res.docs.map((e) => Usuario.fromMap(e.data(), e.id)).toList();
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // 'Body' com tab bar
      home:new DefaultTabController(
        
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'FILMES', icon: Icon(Icons.movie_creation_outlined)),
                Tab(text: 'JOGOS', icon: Icon(Icons.gamepad_rounded)),
                Tab(text: 'LIVROS', icon: Icon(Icons.book_rounded)),
                Tab(text: 'MÚSICAS', icon: Icon(Icons.music_note_rounded)),
              ],
            ),
            title: Text('Categorias'),
            backgroundColor: Theme.of(context).accentColor,
            
          ),
          body: TabBarView(
            children: [
              TelaFilme(),
              TelaJogo(),
              TelaLivro(),
              TelaMusica(),
            ],
          ),

          drawer: new Drawer(
            child: ListView(
              padding: EdgeInsets.zero, // Remove qualquer espaçamento da ListView
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: [
                      nomeUsuario = getUsername(),
                      emailUsuario = getEmail(),
                      Icon(Icons.account_circle, size: 80,),
                      Text(nomeUsuario, style: TextStyle(fontSize: 25)),
                      Text(emailUsuario, style: TextStyle(fontSize: 15)),
                    ]
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                /*ListTile(
                  leading: Icon(Icons.help_outline_rounded),
                  title: Text('Ajuda'),
                  onTap: () {
                    Navigator.pushNamed(context, '/ajuda');
                  },
                ),*/
                ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text('Sobre o Projeto'), // Mostra as informações do tema do projeto
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                /*ListTile(
                  leading: Icon(Icons.settings_rounded),
                  title: Text('Configurações da conta'),
                  onTap: () {
                    Navigator.pushNamed(context, '/configUsuario');
                  },
                ),*/
                ListTile(
                  leading: Icon(Icons.exit_to_app_rounded),
                  title: Text('Sair'),
                  onTap: () {
                    // Voltar para de tela de login ou cadastro:
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //--CUSTOM WIDGET
  caixaDialogo(msg, titulo){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(titulo, style:TextStyle(fontSize: 14)),
          content: Text(msg, style:TextStyle(fontSize: 18)),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('OK')
            )
          ],
        );
      }
    );
  }

  getUsername(){
    for (int i = 0; i<usuarios.length; i++){
      if (usuarios[i].acesso = true) {
        return usuarios[i].nome;
      }
    }
  }

  getEmail(){
    for (int i = 0; i<usuarios.length; i++){
      if (usuarios[i].acesso = true) {
        return usuarios[i].email;
      }
    }
  }
} // TelaPrincipal