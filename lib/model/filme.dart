//
// MODELO DE DADOS para a coleção de FILMES
//
class Filme{
  // Atributos
  String id;
  int ano;
  String diretor;
  String capa;
  String preco;
  String titulo;
  
  // Construtor
  Filme(this.id, this.ano, this.diretor, this.capa, this.preco, this.titulo);

  // Converter DOCUMENTO (mapa) --> OBJETO
  Filme.fromMap(Map<String,dynamic> map, String id){

    // se id não for nulo, então this.id = id; senão this.id = '';
    this.id = id ?? '';
    this.ano = map['ano'];
    this.diretor = map['diretor'];
    this.capa = map['capa'];
    this.preco = map['preco'];
    this.titulo = map['titulo'];
  }
}