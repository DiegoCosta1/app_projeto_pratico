//
// MODELO DE DADOS para a coleção de MUSICAS
//
class Musica{
  // Atributos
  String id;
  int ano;
  String artista;
  String capa;
  String preco;
  String titulo;
  
  // Construtor
  Musica(this.id, this.ano, this.artista, this.capa, this.preco, this.titulo);

  // Converter DOCUMENTO (mapa) --> OBJETO
  Musica.fromMap(Map<String,dynamic> map, String id){

    // se id não for nulo, então this.id = id; senão this.id = '';
    this.id = id ?? '';
    this.ano = map['ano'];
    this.artista = map['artista'];
    this.capa = map['capa'];
    this.preco = map['preco'];
    this.titulo = map['titulo'];
  }
}