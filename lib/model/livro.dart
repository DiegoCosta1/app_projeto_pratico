//
// MODELO DE DADOS para a coleção de LIVROS
//
class Livro{
  // Atributos
  String id;
  int ano;
  String autor;
  String capa;
  String preco;
  String titulo;
  
  // Construtor
  Livro(this.id, this.ano, this.autor, this.capa, this.preco, this.titulo);

  // Converter DOCUMENTO (mapa) --> OBJETO
  Livro.fromMap(Map<String,dynamic> map, String id){

    // se id não for nulo, então this.id = id; senão this.id = '';
    this.id = id ?? '';
    this.ano = map['ano'];
    this.autor = map['autor'];
    this.capa = map['capa'];
    this.preco = map['preco'];
    this.titulo = map['titulo'];
  }
}