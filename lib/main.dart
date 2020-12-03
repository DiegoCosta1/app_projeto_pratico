import 'package:app_projeto_pratico/screens/about.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/cadastroFilme.dart';
import 'screens/cadastroJogo.dart';
import 'screens/cadastroLivro.dart';
import 'screens/cadastroMusica.dart';
import 'screens/cadastroUsuario.dart';
import 'screens/tabFilme.dart';
import 'screens/tabJogo.dart';
import 'screens/tabLivro.dart';
import 'screens/tabMusica.dart';

void main() async {

  // REGISTRAR O FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto Prático/P2',

      // NAVEGAÇÃO
      initialRoute: '/tabLivro',
      routes: {
        '/cadastroFilme' : (context) => TelaCadastroFilme(),
        '/cadastroJogo' : (context) => TelaCadastroJogo(),
        '/cadastroLivro' : (context) => TelaCadastroLivro(),
        '/cadastroMusica' : (context) => TelaCadastroMusica(),
        '/cadastroUsuario' : (context) => TelaCadastroUsuario(),
        '/home' : (context) => TelaPrincipal(),
        '/about' : (context) => TelaSobre(),
        '/login' : (context) => TelaLogin(),
        '/tabFilme' : (context) => TelaFilme(),
        '/tabJogo' : (context) => TelaJogo(),
        '/tabLivro' : (context) => TelaLivro(),
        '/tabMusica' : (context) => TelaMusica(),
      },

      // TEMAS
      theme: ThemeData(
        primaryColor: Colors.yellow[600],
        accentColor: Colors.red[800],
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline2: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 25, color: Colors.grey),
          headline4: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          headline5: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 15, color: Colors.grey[800]),
        )
      ),
    )
  );

  // TESTE DO FIREBASE
  /*
  var db = FirebaseFirestore.instance;
  db.collection("usuarios").add(
    {
      "nome" : "José",
      "email": "jose@gmail.com",
      "senha": "1234",
    }
  );
  print("Adicionado com sucesso");
  */
}