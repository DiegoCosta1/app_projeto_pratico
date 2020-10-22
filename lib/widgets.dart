import 'package:flutter/material.dart';

//
//----------------- FILME
//
class MostrarFilme extends StatelessWidget {
  // Atributos
  final String titulo;
  final String diretor;
  final int ano;
  final String preco;
  final String capa;

  MostrarFilme(this.titulo, this.diretor, this.ano, this.preco, this.capa) : super();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: 180,
        height: 374,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 75, //=(qtd linhas  * 25)
              child: Text(titulo, style: TextStyle(fontSize: 18))
            ),
            Image.asset(
              capa,
              height: 234,
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 40,//=(qtd linhas  * 20)
              child: Text(diretor + ' • ' + ano.toString(), style: TextStyle(color: Colors.grey[400]))
            ),
            Text(preco, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}





//
//----------------- JOGO
//
class MostrarJogo extends StatelessWidget {
  // Atributos
  final String titulo;
  final String console;
  final int ano;
  final String preco;
  final String capa;

  MostrarJogo(this.titulo, this.console, this.ano, this.preco, this.capa) : super();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: 180,
        height: 374,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 75, //=(qtd linhas  * 25)
              child: Text(titulo, style: TextStyle(fontSize: 18))
            ),
            Image.asset(
              capa,
              height: 234,
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 40,//=(qtd linhas  * 20)
              child: Text(console + ' • ' + ano.toString(), style: TextStyle(color: Colors.grey[400]))
            ),
            Text(preco, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}


//
//----------------- LIVRO
//
class MostrarLivro extends StatelessWidget {
  // Atributos
  final String titulo;
  final String autor;
  final int ano;
  final String preco;
  final String capa;

  MostrarLivro(this.titulo, this.autor, this.ano, this.preco, this.capa) : super();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: 180,
        height: 374,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 75, //=(qtd linhas  * 25)
              child: Text(titulo, style: TextStyle(fontSize: 18))
            ),
            Image.asset(
              capa,
              height: 234,
              fit: BoxFit.fitHeight,
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 40,//=(qtd linhas  * 20)
              child: Text(autor + ' • ' + ano.toString(), style: TextStyle(color: Colors.grey[400]))
            ),
            Text(preco, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}


//
//----------------- MÚSICA
//
class MostrarAlbum extends StatelessWidget {
  // Atributos
  final String titulo;
  final String artista;
  final int ano;
  final String preco;
  final String capa;

  MostrarAlbum(this.titulo, this.artista, this.ano, this.preco, this.capa) : super();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: 180,
        height: 300,
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 75, //=(qtd linhas  * 25)
              child: Text(titulo, style: TextStyle(fontSize: 18))
            ),
            Image.asset(
              capa, // layout quadrado
              width: 160,
              height: 160,
              fit: BoxFit.fitWidth
            ),
            Container(
              alignment: Alignment.topLeft,
              height: 40,//=(qtd linhas  * 20)
              child: Text(artista + ' • ' + ano.toString(), style: TextStyle(color: Colors.grey[400]) )
            ),
            Text(preco, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}