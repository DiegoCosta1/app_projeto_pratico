import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/campoTexto.dart';
import '../components/caixaMensagem.dart';
import '../model/usuario.dart';


class TelaCadastroUsuario extends StatefulWidget {
  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  
  // Variáveis de controle
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtConfSenha = TextEditingController();

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 'Formulário' para cadastro
              Column(children: [

                // TÍTULO
                Text('Crie sua conta',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 45),

                // CAMPO DE TEXTO
                campoTexto('Seu nome', txtNome, Icons.account_circle, false, context),
                campoTexto('E-mail', txtEmail, Icons.email_rounded, false, context),
                campoTexto('Senha', txtSenha, Icons.lock_rounded, true, context),
                campoTexto('Confirme sua senha', txtConfSenha, Icons.verified_user_rounded, true, context),
                SizedBox(height: 60),

                // BOTÃO
                Container(
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
                        child: Text('Cadastrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      /*if (txtSenha == txtConfSenha){
                        for (int i = 0; i<usuarios.length; i++){
                          if (usuarios[i].email.contains(txtEmail.text)) {
                            caixaMensagem('E-mail inválido', 'O endereço de e-mail já está sendo utilizado', context);
                          }
                          else if (i == usuarios.length) {*/
                            // CADASTRAR USUÁRIO
                            await db.collection("usuarios").add(
                              {
                                "nome" : txtNome.text,
                                "email" : txtEmail.text,
                                "senha" : txtSenha.text,
                              }
                            );
                            Navigator.pushNamed(context, '/home');
                          /*}
                        }
                      }
                      else{

                      }*/
                      
                      //Navigator.pushNamed(context, '/home');
                    },
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
} // TelaCadastroUsuario