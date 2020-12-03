import 'package:flutter/material.dart';

// CUSTOM WIDGET -- MessageBox
caixaMensagem(title, msg, contexto){
    return showDialog(
      context: contexto,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title, style:TextStyle(fontSize: 12)),
          content: Container(
            height: 120,
            child: ListView(
              children: [
                Text(msg, style:TextStyle(fontSize: 15)),
                SizedBox(height: 10),
              ]
            ),
          ),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('OK', style:TextStyle(fontSize: 15)),
            )
          ],
        );
      }, 
    );
  }