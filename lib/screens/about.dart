import 'package:flutter/material.dart';

//
//----------------- INFORMAÇÕES DO PROJETO
//
class TelaSobre extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Informações do Projeto', style: TextStyle(fontSize: 24))),

      body: Container(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Aluno
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Diego Gabriel da Costa',
                        style: Theme.of(context).textTheme.headline3,
                        //textAlign: TextAlign.right
                      ),
                      Text(
                        'desenvolvedor',
                        style: Theme.of(context).textTheme.headline5,
                        //textAlign: TextAlign.right
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.asset('assets/images/dev.jpg', scale: 2.0, fit: BoxFit.fitWidth,),
                  ),
                ]
              ),

              SizedBox(height: 40),

              // Título
              Text(
                'Projeto Prático em Flutter SDK',
                style: Theme.of(context).textTheme.headline2,
              ),

              SizedBox(height: 5),

              // Descrição do Projeto
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    TextSpan(text: 'Este é um projeto prático da matéria de '),
                    TextSpan(text: 'Programação Para Dispositivos Móveis', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' da '),
                    TextSpan(text: 'Fatec Ribeirão Preto.', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '\nO tema escolhido é um aplicativo para vendas de produtos de entretenimento (livros, músicas, filmes e jogos).'),
                    TextSpan(text: '\nO objetivo do app é mostrar e cadastrar novos produtos da '),
                    TextSpan(text: 'loja fictícia', style:(TextStyle(fontStyle: FontStyle.italic))),
                    TextSpan(text: ' Livros & Discos.', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' Os produtos são armazenados em quatro diferentes coleções do Firebase.'),
                  ]
                ),
              ),
            ]
          )
        )
      )
    );
  }
}