import 'package:flutter/material.dart';
import 'campoTexto.dart';

// CUSTOM WIDGET -- InputBox
caixaEntrada(msg, email, contexto){
    return showDialog(
      context: contexto,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Recuperação de senha', style:TextStyle(fontSize: 12)),
          content: Container(
            height: 120,
            child: ListView(
              children: [
                Text('Uma mensagem será enviada em seu e-mail para redefinir sua senha.', style:TextStyle(fontSize: 15)),
                SizedBox(height: 10),
                campoTexto('E-mail', email, Icons.email_rounded, false, context)
              ]
            ),
          ),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Enviar', style:TextStyle(fontSize: 15)),
            )
          ],
        );
      }, 
    );
  }