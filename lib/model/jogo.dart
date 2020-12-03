//
// MODELO DE DADOS para a coleção de JOGOS
//
class Jogo{
  // Atributos
  String id;
  int ano;
  String desenvolvedora;
  String capa;
  String preco;
  String titulo;
  
  // Construtor
  Jogo(this.id, this.ano, this.desenvolvedora, this.capa, this.preco, this.titulo);

  // Converter DOCUMENTO (mapa) --> OBJETO
  Jogo.fromMap(Map<String,dynamic> map, String id){

    // se id não for nulo, então this.id = id; senão this.id = '';
    this.id = id ?? '';
    this.ano = map['ano'];
    this.desenvolvedora = map['desenvolvedora'];
    this.capa = map['capa'];
    this.preco = map['preco'];
    this.titulo = map['titulo'];
  }
}