//
// MODELO DE DADOS para a coleção USUARIOS
//
class Usuario{
  // Atributos
  String id;
  String nome;
  String email;
  String senha;
  bool acesso;

  // Construtor
  Usuario(this.id, this.nome, this.email, this.senha, this.acesso);

  // Converter DOCUMENTO (mapa) --> OBJETO
  Usuario.fromMap(Map<String,dynamic> map, String id){

    // se id não for nulo, então this.id = id; senão this.id = '';
    this.id = id ?? '';
    this.nome = map['nome'];
    this.email = map['email'];
    this.senha = map['senha'];
    this.acesso = map['acesso'];
  }

  /*
  EXEMPLO DE MAPA
  {
    //chave : valor,
    "nome" : "Diego",
    "email" : "diego@email.com"
    "senha" : "1234"
  }
  */
}