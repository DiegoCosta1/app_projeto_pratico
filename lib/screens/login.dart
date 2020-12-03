import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/campoTexto.dart';
import '../components/caixaEntrada.dart';
//import '../components/caixaMensagem.dart';
import '../model/usuario.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  var txtSenha = TextEditingController();
  var txtEmail = TextEditingController();

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 'Formulario' de Login
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // LOGOTIPO
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset('assets/images/logo.jpg', scale: 5.0, fit: BoxFit.fitWidth,),
                  ),
                  SizedBox(height: 20),

                  // TÍTULO
                  Text('Entre na sua conta',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 45),

                  // CAMPO DE TEXTO
                  campoTexto('E-Mail', txtEmail, Icons.account_circle, false, context),
                  campoTexto('Senha', txtSenha, Icons.lock_rounded, true, context),
                  SizedBox(height: 15),

                  // ESQUECEU A SENHA?
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: 'Esqueci minha senha',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          caixaEntrada('Digite seu e-mail', txtEmail, context);
                        }
                      ),
                    ),
                  ),
                  SizedBox(height: 60),

                  // BOTÃO
                  Container(
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.yellow[700], Colors.yellow[400]],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text('Entrar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // REALIZAR LOGIN
                      onPressed: (){

                        // CONSERTAR ELSE
                        for (int i = 0; i<usuarios.length; i++){
                          if (usuarios[i].email.contains(txtEmail.text)) {
                            if (usuarios[i].senha == txtSenha.text){
                              usuarios[i].acesso = true;
                              Navigator.pushNamed(context, '/home');
                            }
                          }
                        }
                      },
                    ),
                  ),
                ]
              ),

              SizedBox(height: 30),

              // 'link' para realizar cadastro
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Não possui uma conta? Cadastre-se aqui',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()

                    // Navegue para tela de cadastro
                    ..onTap = (){ 
                      Navigator.pushNamed(context, '/cadastroUsuario');
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}