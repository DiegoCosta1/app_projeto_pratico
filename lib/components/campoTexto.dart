import 'package:flutter/material.dart';

// CUSTOM WIDGET -- TextBox
Widget campoTexto(rotulo, controle, icone, oculto, context){
  return ListTile(
    leading: Icon(icone, color: Colors.grey[800]),
    title: TextFormField(
      obscureText: oculto,
      controller: controle,
      cursorColor: Theme.of(context).primaryColor,        
      decoration: InputDecoration(
        hintText: rotulo,
        contentPadding: EdgeInsets.only(left: 5)
      ), 
    ),
  );
}